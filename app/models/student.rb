class Student < ApplicationRecord
  belongs_to :address
  has_many :student_rosters
  has_many :courses, through: :student_rosters
  has_many :attendances

  @gender = ['male', 'female']

  enum gender: @gender
  email_expression = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :first_name, presence: true, length: { minimum: 2, maximum: 30 }
  validates :last_name, presence: true, length: { minimum: 2, maximum: 30 }
  validates :phone, presence: true
  validates :email, presence: true, format: { with: email_expression }
  validates :birth_date, presence: true
  validates :gender, presence: true, inclusion: { in: @gender }

  # Return a list of all student attendance for a specified course. Used in course show to properly display the attendance
  def student_attendance(course)
    Attendance.joins("INNER JOIN sessions ON sessions.id = attendances.session_id and attendances.student_id = #{self.id} INNER JOIN courses ON sessions.course_id = courses.id and courses.id= #{course.id}")
  end

  def age(dob)
    now = Date.today
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end

  def absent_student
    Attendance.where(present: "absent")
    #I want to select the students that haven't shown up to any course
    #Their present: status should be marked "absent" for all sessions up to todays date
  end

end
