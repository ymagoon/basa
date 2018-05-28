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
    teacher = self.volunteer_rosters.find { |volunteer| volunteer.role == 'teacher' }
    teacher ? teacher.user : ''
  end

  def assistants
    assistants = self.volunteer_rosters.select { |volunteer| volunteer.role == 'assistant' }.map(&:user)
    assistants.empty? ? [] : assistants
  end

  def date_formatted(date)
    date.strftime('%A, %b %d')
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

  scope :courses_below_min_cap, -> { select{ |c| c.min_capacity > c.number_of_students } }

  # def courses_below_min_capacity
  #   self.all.select { |c| c.min_capacity > c.number_of_students }
  # end

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

  # Create all of the sessions for the course after the course itself is created
  def create_sessions
    self.schedule.occurrences(self.end_date).each do |session|
      Session.create(course: self, date: session)
    end
  end


end
