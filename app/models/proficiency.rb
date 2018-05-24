class Proficiency < ApplicationRecord
  belongs_to :subject
  belongs_to :user

  enum role: ROLES # ROLES defined in application_record.rb

  validates :role, presence: true, inclusion: { in: ROLES }
end
