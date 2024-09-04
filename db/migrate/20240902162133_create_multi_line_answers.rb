class CreateMultiLineAnswers < ActiveRecord::Migration[7.1]
  def change
    create_table :multi_line_answers do |t|
      t.text :value, null: false
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
