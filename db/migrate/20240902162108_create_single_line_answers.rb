class CreateSingleLineAnswers < ActiveRecord::Migration[7.1]
  def change
    create_table :single_line_answers do |t|
      t.string :value
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
