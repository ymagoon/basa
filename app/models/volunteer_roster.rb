class VolunteerRoster < ApplicationRecord
  belongs_to :user
  belongs_to :course

  enum role: ROLES # ROLES defined in application_record.rb

  validates :role, presence: true, inclusion: { in: ROLES }

  def self.roles
    ROLES
  end
end
