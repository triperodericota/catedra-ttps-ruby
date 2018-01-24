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
    unless (self.date.year == self.course.year)
      errors.add(:evaluations, 'must be same year of course')
    end
  end

  def amount_of_approved?
    self.student_grade.where('grade >= ?', self.approbation_grade).size
  end

  def amount_of_disapproved?
    self.student_grade.size - self.amount_of_approved?
  end

  def amount_of_absentees?
    self.course.students.size - self.students.size
  end

  def approval_percentage?
    begin
      self.amount_of_approved? / (self.course.students.size - self.amount_of_absentees?)
    rescue ZeroDivisionError
        0
    end
  end

end
