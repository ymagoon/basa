class Attendance < ApplicationRecord
  belongs_to :student
  belongs_to :session

  before_create :default_attendance

  @presence = ['absent', 'present']
  enum present: @presence

  def default_attendance
    self.present = 'absent'
  end

  validates :present, presence: true, inclusion: { in: @presence }

  def set_attendance_percentage
    total = Attendance.all.count
    present = Attendance.where(present: "present").count
    @percentage_attendance = present.to_f / total
  end
end
