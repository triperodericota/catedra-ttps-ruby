class SorceryCore < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email,            :null => false
      t.string :crypted_password
      t.string :salt
      t.string :first_name, :null => false , limit: 30
      t.string :last_name, :null => false, limit: 30
      t.timestamps                :null => false
    end

    add_index :users, :email, unique: true
  end
end
