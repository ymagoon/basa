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

  @frequencies = ['daily', 'weekly', 'biweekly', 'monthly']
  enum frequency: @frequencies
  enum status: ['pending', 'confirmed', 'cancelled']

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :frequency, presence: true, inclusion: { in: @frequencies}
  validates :number_of_sessions, :numericality => { :only_integer => true }
  validates :min_capacity, presence: true, :numericality => { :only_integer => true }
  validates :session_length, presence: true, :numericality => { :only_integer => true }

  private

  def set_default_status
    self.status = 0
  end
end
