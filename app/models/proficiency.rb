class Proficiency < ApplicationRecord
  belongs_to :subject
  belongs_to :user

  @roles = [:teacher, :volunteer]

  enum role: @roles

  validates :role, presence: true, inclusion: { in: @roles }
end
