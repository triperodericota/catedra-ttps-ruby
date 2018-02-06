class Student < ApplicationRecord

  has_many :student_grades, dependent: :destroy
  has_many :evaluations, through: :student_grades
  has_and_belongs_to_many :courses

  validates :first_name, null: false, presence: true, length: { maximum: 30 }
  validates :last_name, null: false, presence: true, length: { maximum: 30 }
  validates :dni, null: false, presence: true, uniqueness: true ,numericality: { only_integer: true }, length: { in: 7..8 }
  validates :email, null: false, presence: true, uniqueness: true, :email_format => { :message => 'email is invalid' }
  validates :number, presence: false, length: { maximum: 10 }
  validates_associated :courses


  def to_s
    self.first_name + " " + self.last_name
  end

  def grade_in?(an_evaluation)
    evaluation = self.student_grades.find_by(evaluation: an_evaluation)
    return "Ausente" if evaluation.nil?
    evaluation.grade
  end

end
