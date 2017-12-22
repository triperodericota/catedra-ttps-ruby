class StudentGrade < ApplicationRecord
  belongs_to :evaluation
  belongs_to :student
end
