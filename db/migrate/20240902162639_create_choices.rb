class CreateChoices < ActiveRecord::Migration[7.1]
  def change
    create_table :choices do |t|
      t.string :value
      t.boolean :marked, default: false
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
