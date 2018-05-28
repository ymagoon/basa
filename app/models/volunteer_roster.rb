class VolunteerRoster < ApplicationRecord
  belongs_to :user
  belongs_to :course

  enum role: ROLES # ROLES defined in application_record.rb

  validates :role, presence: true, inclusion: { in: ROLES }
  validates :user, uniqueness: { scope: :course }

  def self.roles
    ROLES
  end

  def self.courses_by_volunteer(volunteer)
    VolunteerRoster.joins(:course).where('user_id = ? AND start_date > ?', volunteer, DateTime.now).order('courses.start_date DESC')
  end

  def format_date(date)
    date.strftime('%a %d %b')
  end
end
