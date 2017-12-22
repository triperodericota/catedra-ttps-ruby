class Evaluation < ApplicationRecord
  belongs_to :course

  validates :title, null: false, length: {maximum: 30}, presence: true
  validates :approbation_grade, null: false
  validates :date, null: false, presence: true
  validates :course_id, null: false, presence: true


end
