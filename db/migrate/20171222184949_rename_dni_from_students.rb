class RenameDniFromStudents < ActiveRecord::Migration[5.1]
  def change
    rename_column :students, :DNI, :dni
  end
end
