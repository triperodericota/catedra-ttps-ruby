class Evaluation < ApplicationRecord
  belongs_to :course
  has_many :student_grade, dependent: :destroy
  has_many :students, through: :student_grade

  accepts_nested_attributes_for :student_grade, allow_destroy: true

  validates :title, null: false, length: {maximum: 30}, presence: true
  validates :approbation_grade, null: false, numericality: { greater_than: 0 }
  validates :date, null: false, presence: true
  validates :course, null: false, presence: true
  validates_associated :course
  validate :evaluation_year_equals_to_course_year

  def evaluation_year_equals_to_course_year
    begin
      unless (self.date.year == self.course.year)
        errors.add(:evaluations, 'must be same year of course')
      end
    rescue
        errors.add(:evaluations, 'must be select a course')
    end
  end

  def students_grades_for_form

  end



  def amount_of_approved?
    self.student_grade.where('grade >= ?', self.approbation_grade).size
  end

  def amount_of_disapproved?
    self.student_grade.size - self.amount_of_approved?
  end

  def amount_of_absentees?
    self.course.students.size - self.student_grade.size
  end

  def approval_percentage?
    return 0 if self.course.students.size == self.amount_of_absentees?
    (self.amount_of_approved?.to_f / (self.course.students.size - self.amount_of_absentees?).to_f).round 2
  end

end
