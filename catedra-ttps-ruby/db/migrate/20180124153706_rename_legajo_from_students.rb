class RenameLegajoFromStudents < ActiveRecord::Migration[5.1]
  def change
    rename_column :students, :legajo, :number
  end
end
