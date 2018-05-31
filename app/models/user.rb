class User < ApplicationRecord
  attr_accessor :login

  has_many :proficiencies
  has_many :volunteer_rosters

  # enum allows us to call user.admin? user.volunteer? => true/false user.role => 'admin' || 'volunteer'
  enum role: [:admin, :volunteer]
  before_create :set_default_role

  # scope :ruby_on_rails_portfolio_items, -> { where(subtitle: 'Ruby on Rails') }
  scope :volunteers, -> { where(role: 1) }
  scope :admins, -> { where(role: 0) }
  # scope :last_week, -> { where('role = volunteer and created_at < ?', DateTime.now - 7) }

  validates :username, presence: :true, uniqueness: { case_sensitive: false }, length: { minimum: 6 }

  # So users don't create a username formatted like an email. Prevents issues where users might use an email as their username
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true
  validate :validate_username # Username must be unique

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def login
    @login || self.username || self.email
  end

  # Overwrite find_for_database_authentication Devise default behavior for login action. Overriding this method allows us to edit
  # the database authentication
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  def full_name
    "#{first_name} #{last_name}".titleize
  end

  def number_of_volunteers_assigned_to_course
     # total number of volunteers
    users = self.where(role: 'volunteer').count

    #total number of distinct users on volunteer_rosters
    distinct_users = VolunteerRoster.select(:user_id).distinct.count

    users - distinct_users
    # show # of volunteers that have never been assigned to a course
  end

  def self.total_number_of_volunteers
    self.where(role: 'volunteer').count
  end

  def self.unassigned_vols
    user_ids = Proficiency.all.map { |p| p.user_id }
    self.all.reject { |ids| User.ids.include? user_ids }
  end


  private

  def set_default_role
    self.role ||= :volunteer
  end

  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end

end




