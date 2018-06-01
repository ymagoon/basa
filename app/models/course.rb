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

  # Define all of the scopes for filtering and sorting on the index page

  # Course location filters
  scope :locations, -> (locations) { where('addresses.venue_name': locations).joins(:address) }
  # lists each venue (as a hash) with how many other courses have that same address

  scope :venue_list, -> { self.each_with_object(Hash.new(0)) { |obj, counts| counts[obj.address.venue_name] += 1 } }

  # Course subject filters
  scope :subject_list, -> { self.each_with_object(Hash.new(0)) { |obj, counts| counts[obj.subject.name] += 1 } }
  scope :subjects, ->(subjects) { where('subjects.name': subjects).joins(:subject) }

  # Course status filters
  scope :status, -> (status) { where(status: status) }

  # Course phase filters
  # These three filters do not work together because of their conditions. Need to find a way where they wont overwrite each other!

  scope :current, -> { where("? between start_date and end_date", DateTime.now)}
  scope :future, -> { where("start_date > ?", DateTime.now)}
  scope :active, -> { self.current.or(self.future) }
  scope :past, -> { where("? > end_date", DateTime.now)}
  # scope :last_week, -> { where('created_at < ?', DateTime.now - 7) }

  # Course date range filters

  # Miscellaneous filters
  scope :with_no_teacher, -> { where('id not in (select course_id from volunteer_rosters where role = ?)', 0) }
  scope :with_no_assistants, -> { where('id not in (select course_id from volunteer_rosters where role = ?)', 1) }

  # Course sorting scopes
  scope :order_by_start_date, -> { order(start_date: :asc)}
  scope :order_by_end_date, -> { order(start_date: :desc)}

  scope :group_by_subject, -> { self.joins(:subject).group('subjects.name').count }

  def self.total_attendance
    if self.count > 0
      (self.all.map { |c| c.course_attendance }.reduce(:+) / Course.count).round(2)
    else
      0
    end
  end

# FOR ATTENDANCE BASED ON PASSED SESSIONS/ATTENDANCES
  def course_attendance
    s = self.sessions.select do |session|
      if session.date <= DateTime.now
        session.id
      end
    end
    attendance = self.attendances.where(session_id: s.map(&:id))
    percentage = (attendance.present.count.to_f / attendance.count.to_f) * 100
    if percentage.nan?
      return 0
    else
      percentage.round(2)
    end
  end

  def self.lowest_attendance
    self.all.sort_by { |course|
      course.course_attendance
    }
  end

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
    date.strftime('%a, %b %d')
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

  # def self.active_courses
  #   self.all.select { |c| c.status != 'cancelled'}
  # end

  def list_occurrences
    self.schedule.occurrences(self.end_date)
  end

  scope :courses_below_min_cap, -> { select{ |c| c.min_capacity > c.number_of_students } }

  # def courses_below_min_capacity
  #   self.all.select { |c| c.min_capacity > c.number_of_students }
  # end

  def self.no_teacher
    courses_w_teachers = VolunteerRoster.all.map { |a| a.course_id}.uniq
    ids = self.all.ids - courses_w_teachers
    courses_with_no_teacher = ids.map { |id| Course.find(id) }
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

  # Create all of the sessions for the course after the course itself is created
  def create_sessions
    self.schedule.occurrences(self.end_date).each do |session|
      Session.create(course: self, date: session)
    end
  end


end
