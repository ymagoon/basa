class Subject < ApplicationRecord
  has_many :proficiencies
  has_many :courses

  validates :name, presence: true
end
