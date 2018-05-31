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

  scope :group_by_gender, -> { group(:gender).count }
  scope :group_by_age, -> { self.each_with_object(Hash.new(0)) { |obj, counts| counts[obj.age2] += 1 } }
  # scope :last_week, -> { where('created_at < ?', DateTime.now - 7) }

  # Return a list of all student attendance for a specified course. Used in course show to properly display the attendance
  def student_attendance(course)
    Attendance.joins("INNER JOIN sessions ON sessions.id = attendances.session_id and attendances.student_id = #{self.id} INNER JOIN courses ON sessions.course_id = courses.id and courses.id= #{course.id} order by attendances.id")
  end

  def age(dob)
    now = Date.today
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end

  def age2
    DateTime.now.year - self.birth_date.year
  end

  def birth_date_formatted
    self.birth_date.strftime("%d/%m/%Y")
  end

  def self.absent_student
    Student.all.select { |student|
      student.attendances.all? { |attendance| attendance.absent? }
    }
  end

  def attendance_percentage
    a = self.attendances
    if a.empty?
      return 0
    else
      (a.present.count / a.count.to_f).round(2) * 100
    end
  end

  def self.lowest_attendance
    list = self.all.sort_by { |student| student.attendance_percentage }
  end
end
