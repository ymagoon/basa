class Proficiency < ApplicationRecord
  belongs_to :subject
  belongs_to :user

  # scope :by_subject, -> (subject) { joins(:subjects).where('subjects.name = ?', subject) }
  # scope :by_role, -> (role) { where(role: role) }

  enum role: ROLES # ROLES defined in application_record.rb

  validates :role, presence: true, inclusion: { in: ROLES }

  # Currently counts users twice if they are assistants and teachers
  scope :group_by_subject, -> { self.joins(:subject).group(:name).count }

  def self.teachers_by_subject(subject)
    Proficiency.joins(:subject).where('subjects.name = ? AND role = 0', subject)
  end

  def self.assistants_by_subject(subject)
    Proficiency.joins(:subject).where('subjects.name = ? AND role = 1', subject)
  end
end
