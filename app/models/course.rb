class Course < ApplicationRecord
  belongs_to :subject
  belongs_to :address
  has_many :volunteer_rosters, dependent: :destroy
  has_many :student_rosters, dependent: :destroy
  has_many :students, through: :student_rosters
  has_many :users, through: :volunteer_rosters
  has_many :sessions, dependent: :destroy
  has_many :attendances, through: :sessions, dependent: :destroy

  before_create :set_default_status, :set_number_of_sessions, :set_notes
  after_create :create_sessions

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
  validates :min_capacity, presence: true, :numericality => { :only_integer => true }
  validates :session_length, presence: true, :numericality => { :only_integer => true }

  def number_of_students
    self.students.count
  end

  def teacher
    self.volunteer_rosters.find { |volunteer| volunteer.role == 'teacher' }.user
  end

  def assistants
    self.volunteer_rosters.select { |volunteer| volunteer.role == 'assistant' }.map(&:user)
  end

  def schedule
    # Creates a schedule of dates for a Course depending on what the start_date, end_date and
    # frequency of the course is
    schedule = IceCube::Schedule.new(now = start_date)

    case frequency
    when 'daily'
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

  def list_occurrences
    self.schedule.occurrences(self.end_date)
  end

  private

  # When a course is created, default the status to pending
  def set_default_status
    self.status = 0
  end

  # Set the total number of sessions
  def set_number_of_sessions
    self.number_of_sessions = schedule.occurrences(end_date).count
  end

  # Default the note to a blank string if the user doesn't enter a note
  def set_notes
    self.notes ||= ''
  end

  # times come from the datepicker as a string like "6/11/2018 12:00 PM - 6/28/2018 12:00 PM"
#   def parse_times
#     self.
#     DateTime.strptime('2001-02-03T04:05:06+07:00', '%Y-%m-%dT%H:%M:%S%z')
#                           #=> #<DateTime: 2001-02-03T04:05:06+07:00 ...>
# DateTime.strptime('03-02-2001 04:05:06 PM', '%d-%m-%Y %I:%M:%S %p')
#                           #=> #<DateTime: 2001-02-03T16:05:06+00:00 ...>
# DateTime.strptime('2001-W05-6T04:05:06+07:00', '%G-W%V-%uT%H:%M:%S%z')
#                           #=> #<DateTime: 2001-02-03T04:05:06+07:00 ...>
# DateTime.strptime('2001 04 6 04 05 06 +7', '%Y %U %w %H %M %S %z')
#                           #=> #<DateTime: 2001-02-03T04:05:06+07:00 ...>
# DateTime.strptime('2001 05 6 04 05 06 +7', '%Y %W %u %H %M %S %z')
#   end

  # Create all of the sessions for the course after the course itself is created
  def create_sessions
    self.schedule.occurrences(self.end_date).each do |session|
      Session.create(course: self, date: session)
    end
  end
end
