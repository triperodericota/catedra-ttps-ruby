class RenameStudentsGradesToStudentGrades < ActiveRecord::Migration[5.1]
  def change
    rename_table :students_grades, :student_grades
  end
end