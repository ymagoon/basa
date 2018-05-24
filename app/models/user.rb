class User < ApplicationRecord
  attr_accessor :login

  # enum allows us to call user.admin? user.volunteer? => true/false user.role => 'admin' || 'volunteer'
  enum role: [:admin, :volunteer]
  before_create :set_default_role

  scope :volunteers, -> { where('role = 1') }
  scope :admins, -> { where('role = 0') }

  # scope :ruby_on_rails_portfolio_items, -> { where(subtitle: 'Ruby on Rails') }


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




