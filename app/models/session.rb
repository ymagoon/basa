class Session < ApplicationRecord
  belongs_to :course
  has_many :attendances

  validates :date, presence: true

  def date_formatted
    self.date.strftime('%a, %b %d')
  end

  scope :past, -> { where("? > end_date", DateTime.now)}
end
