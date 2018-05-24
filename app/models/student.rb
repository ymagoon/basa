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


  def age(dob)
    now = Date.today
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
end
