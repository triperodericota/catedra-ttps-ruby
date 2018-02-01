class CreateStudentGrades < ActiveRecord::Migration[5.1]
  def change
    create_table :students_grades do |t|
      t.decimal :grade, precision: 2, scale: 2
      t.references :evaluation, foreign_key: true
      t.references :student, foreign_key: true

      t.timestamps
    end
  end
end
