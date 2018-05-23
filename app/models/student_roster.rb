class StudentRoster < ApplicationRecord
  belongs_to :student_id
  belongs_to :course_id

  @role = ['teacher', 'assistant']

  enum role: @role

  validates :role, presence: true, inclusion: { in: @role }
end
