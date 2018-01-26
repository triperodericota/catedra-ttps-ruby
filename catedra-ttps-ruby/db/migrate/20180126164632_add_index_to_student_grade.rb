class AddIndexToStudentGrade < ActiveRecord::Migration[5.1]
  def change
    change_table :student_grades do |t|
      add_index :student_grades, [:evaluation_id, :student_id], unique: true
    end
  end
end
