class User < ApplicationRecord
  attr_accessor :login

  enum role: [:volunteer, :admin]
  before_create :set_default_role

  validates :username, presence: :true, uniqueness: { case_sensitive: false }, length: { minimum: 6 }
  # Only allow letter, number, underscore and punctuation. This is important so users don't create a username
  # formatted like an email. Prevents issues where users might use an email as their username
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true
  # Make the validation even more secure
  validate :validate_username

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def login
    @login || self.username || self.email
  end

  # Because we want to change the behavior of the login action, we have to overwrite the find_for_database_authentication method.
  # The method's stack works like this: find_for_database_authentication calls find_for_authentication which calls
  # find_first_by_auth_conditions. Overriding the find_for_database_authentication method allows you to edit database
  # authentication; overriding find_for_authentication allows you to redefine authentication at a specific point (such as token,
  # LDAP or database). Finally, if you override the find_first_by_auth_conditions method, you can customize finder methods
  # (such as authentication, account unlocking or password recovery).
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
    puts 'testing123 blah blah'
  end

  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end
end




