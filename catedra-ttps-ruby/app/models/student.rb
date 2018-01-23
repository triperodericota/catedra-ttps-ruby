class Student < ApplicationRecord

  has_many :student_grades
  has_many :evaluations, through: :student_grades
  has_and_belongs_to_many :courses

  validates :first_name, null: false, presence: true, length: { maximum: 30 }
  validates :last_name, null: false, presence: true, length: { maximum: 30 }
  validates :dni, null: false, presence: true, uniqueness: true ,numericality: { only_integer: true, greater_than_or_equal_to: 1000000 }
  validates :email, null: false, presence: true, uniqueness: true
  validates :legajo, presence: false
  validates_associated :courses

end
