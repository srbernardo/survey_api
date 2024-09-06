class CreateSurveys < ActiveRecord::Migration[7.1]
  def change
    create_table :surveys do |t|
      t.string :title, null: false
      t.boolean :open, default: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
