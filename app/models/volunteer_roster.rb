class VolunteerRoster < ApplicationRecord
  belongs_to :user
  belongs_to :course

  # @roles = { teacher: 0, assistant: 1 }
  @roles = ['teacher','assistant']


  enum role: @roles

  validates :role, presence: true, inclusion: { in: @roles }

  def self.roles
    @roles
  end
end
