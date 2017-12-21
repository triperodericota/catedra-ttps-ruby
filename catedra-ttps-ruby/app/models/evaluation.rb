class Evaluation < ApplicationRecord
  belongs_to :course

  validates :title, null: false, length: {maximum: 30}
  validates :approbation_grade, null: false
  validates :date, null: false


end
