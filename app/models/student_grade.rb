class StudentGrade < ApplicationRecord
  belongs_to :evaluation
  belongs_to :student

  validates :student, null: false, presence: true
  validates :evaluation, null: false, presence: true
  validates :grade, null: false, numericality: true
  validates_associated :evaluation, :student

  def approved?
    self.grade >= evaluation.approbation_grade
  end

end
