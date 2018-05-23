class VolunteerRoster < ApplicationRecord
  belongs_to :user
  belongs_to :course

  @role = ['teacher', 'assistant']

  enum role: @role

  validates :role, presence: true, inclusion: { in: @role }
end
