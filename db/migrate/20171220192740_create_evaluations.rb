class CreateEvaluations < ActiveRecord::Migration[5.1]
  def change
    create_table :evaluations do |t|
      t.string :title, limit: 30, null: false
      t.integer :approbation_grade, null: false
      t.datetime :date, null: false
      t.references :course, foreign_key: true

      t.timestamps
    end
  end
end
