class StudentRoster < ApplicationRecord
  belongs_to :student
  belongs_to :course

  after_create :create_attendance

  private

  def create_attendance
    course = Course.find(self.course_id)

    course.sessions.each do |session|
      Attendance.create(student_id: self.student_id, session: session)
    end
  end


  def destroy_attendance
    course = Course.find(self.course_id)
  end
end
