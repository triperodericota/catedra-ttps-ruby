class AddColumnModifierToStudentgrade < ActiveRecord::Migration[5.1]
  def change
    change_column :student_grades, :grade, :decimal
  end
end
