class StudentRoster < ApplicationRecord
  belongs_to :student_id
  belongs_to :course_id
end
