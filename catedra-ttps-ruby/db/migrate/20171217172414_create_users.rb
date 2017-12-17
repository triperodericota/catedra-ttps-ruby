class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name, limit: 30
      t.string :last_name, limit: 30
      t.string :email
      t.string :password_digest

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
