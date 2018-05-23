class Session < ApplicationRecord
  belongs_to :course
  has_many :attendances
end
