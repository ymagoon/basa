class Subject < ApplicationRecord
  has_many :proficiencies
  has_many :courses

  validates :name, presence: true

  def teachers
    self.proficiencies.map do |proficiency|
      User.find(proficiency.user_id)
    end
  end
end
