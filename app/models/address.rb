class Address < ApplicationRecord
  has_many :courses
  has_many :users
  has_many :students

  @address_type = ['venue', 'volunteer', 'student']

  enum address_type: @address_type
  scope :venues, -> { where(address_type: 'venue') }

  validates :venue_name, uniqueness: true, allow_blank: true
  validates :address_1, presence: true
  validates :postal_code, presence: true
  validates :city, presence: true
  validates :address_type, presence: true, inclusion: { in: @address_type }

  def self.venues
    Address.all.select { |address| address.venue? }.map { |address| address.venue_name }
  end
end
