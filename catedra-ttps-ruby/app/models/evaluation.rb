class Evaluation < ApplicationRecord
  belongs_to :course
  has_many :student_grade
  has_many :students, through: :student_grade

  validates :title, null: false, length: {maximum: 30}, presence: true
  validates :approbation_grade, null: false
  validates :date, null: false, presence: true
  validates :course_id, null: false, presence: true


end
