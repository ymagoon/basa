class VolunteerRoster < ApplicationRecord
  belongs_to :user
  belongs_to :course

  enum role: ROLES # ROLES defined in application_record.rb

  validates :role, presence: true, inclusion: { in: ROLES }

  def self.roles
    ROLES
  end

#   def self.rosters_by_volunteer(volunteer)
#     VolunteerRoster.joins(:course).where('user_id = ? AND start_date > DateTime.now', volunteer).order(start_date: :desc)
#   end
# end

