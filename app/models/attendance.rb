class Attendance < ApplicationRecord
  # belongs_to :student
  belongs_to :session

  enum present: [:absent, :present]

  validates :present, presence: true, inclusion: { in: [0, 1] }
end
