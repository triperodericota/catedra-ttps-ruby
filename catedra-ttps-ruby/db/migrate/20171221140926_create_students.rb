class CreateStudents < ActiveRecord::Migration[5.1]
  def change
    create_table :students do |t|
      t.string :first_name, limit: 30, null: false
      t.string :last_name, limit: 30, null: false
      t.integer :DNI, limit: 8, null: false
      t.string :legajo, limit: 10
      t.string :email

      t.timestamps
    end
    add_index :students, :email, unique: true
  end
end
