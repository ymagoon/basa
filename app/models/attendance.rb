class Attendance < ApplicationRecord
  belongs_to :student
  belongs_to :session

  @presence = [:absent, :present]

  enum present: @presence

  validates :present, presence: true, inclusion: { in: @presence }
end
