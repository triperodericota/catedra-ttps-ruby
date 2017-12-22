class Course < ApplicationRecord

  has_many :evaluations
 has_and_belongs_to_many :students

  validates :year, null: false, uniqueness: true, inclusion: { in: :years_range }, presence: true
  validates_associated :evaluations
  validate :evaluations_year_equals_to_course_year

  def evaluations_year_equals_to_course_year
    validations = self.evaluations.each { |evaluation| evaluation.date.year == self.year }
    errors.add(:evaluations, 'must be same year of course') if validations.include? false
  end

  def years_range
    four_years_ago = Date.current.years_ago 4
    four_years_since = Date.current.years_since 4
    (four_years_ago.year ... four_years_since.year).to_a
  end

  def to_s
    self.year.to_s
  end


end
