class Course < ApplicationRecord
  belongs_to :subject
  belongs_to :address
  has_many :volunteer_rosters
  has_many :student_rosters
  has_many :students, through: :student_rosters
  has_many :users, through: :volunteer_rosters
  has_many :sessions
  has_many :attendances, through: :sessions

  before_create :set_default_status

  def self.frequencies
    [:daily, :weekly, :biweekly, :monthly]
  end

  def self.statuses
    ['pending', 'confirmed', 'cancelled']
  end

  enum frequency: self.frequencies
  enum status: self.statuses

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :frequency, presence: true, inclusion: { in: self.frequencies.keys }
  validates :number_of_sessions, :numericality => { :only_integer => true }
  validates :min_capacity, presence: true, :numericality => { :only_integer => true }
  validates :session_length, presence: true, :numericality => { :only_integer => true }

  def number_of_students
    self.students.count
  end

  def schedule
    # Creates a schedule of dates for a Course depending on what the start_date, end_date and
    # frequency of the course is
    schedule = IceCube::Schedule.new(now = start_date)

    case frequency
    when 'dialy'
      schedule.add_recurrence_rule IceCube::Rule.daily.until(end_date)
    when 'weekly'
      schedule.add_recurrence_rule IceCube::Rule.weekly.until(end_date)
    when 'biweekly'
      schedule.add_recurrence_rule IceCube::Rule.weekly(2).until(end_date)
    when 'monthly'
      schedule.add_recurrence_rule IceCube::Rule.monthly(1).until(end_date)
    end
    schedule
  end

  private

  # When a course is created, default the status to pending
  def set_default_status
    self.status = 0
  end
end
