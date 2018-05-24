class Attendance < ApplicationRecord
  belongs_to :student
  belongs_to :session

  # before_create :default_attendance

  @presence = ['absent', 'present']
  enum present: @presence

  def default_attendance
    self.present = 'absent'
  end

  # def update
  #   self.present? ? self.
  # end

  validates :present, presence: true, inclusion: { in: @presence }
end
