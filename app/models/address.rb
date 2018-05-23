class Address < ApplicationRecord
  has_many :courses
  has_many :users
  has_many :students

  validates: venue_name, uniqueness: true
  validates: address_1, presence: true
  validates: postal_code, presence: true
  validates: city, presence: true
  validates: address_type, presence: true
end
