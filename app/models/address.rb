class Address < ApplicationRecord
  has_many :courses
  has_many :users
  has_many :students

  @address_type = ['venue', 'volunteer', 'student']

  enum address_type: @address_type

  validates :venue_name, uniqueness: true
  validates :address_1, presence: true
  validates :postal_code, presence: true
  validates :city, presence: true
  validates :address_type, presence: true, inclusion: { in: @address_type }
end
