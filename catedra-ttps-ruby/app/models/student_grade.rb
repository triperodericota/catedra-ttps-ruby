class StudentGrade < ApplicationRecord
  belongs_to :evaluation
  belongs_to :student

  validates_associated :evaluation, :student

  def approved?
    self.grade >= evaluation.approbation_grade
  end

end
