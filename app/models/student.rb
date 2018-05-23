class Student < ApplicationRecord
  belongs_to :address_id
  has_many :student_rosters
  has_many :courses, through :student_rosters
  has_many :attendances

  validates: first_name, presence: true
  validates: last_name, presence: true
  validates: phone, presence: true
  validates: email, presence: true
  validates: birth_date, presence: true
  validates: gender, presence: true
end
