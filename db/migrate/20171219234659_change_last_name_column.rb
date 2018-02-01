class ChangeLastNameColumn < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :last_name, :string, :limit => 30
  end
end
