class Course < ApplicationRecord

  has_many :evaluations

  four_years_ago = Date.current.years_ago 4
  four_years_since = Date.current.years_since 4
  years_range = (four_years_ago.year ... four_years_since.year).to_a

  validates :year, null: false, uniqueness: true, inclusion: { in: years_range}
  validates_associated :evaluations

end
