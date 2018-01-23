class Evaluation < ApplicationRecord
  belongs_to :course
  has_many :student_grade
  has_many :students, through: :student_grade

  validates :title, null: false, length: {maximum: 30}, presence: true
  validates :approbation_grade, null: false, numericality: { greater_than: 1 }
  validates :date, null: false, presence: true
  validates :course, null: false, presence: true
  validates_associated :course
  validate :evaluation_year_equals_to_course_year

  def evaluation_year_equals_to_course_year
    unless (self.date.year == course.year)
      errors.add(:evaluations, 'must be same year of course')
    end
  end

end
