class CreateChoiceAnswers < ActiveRecord::Migration[7.1]
  def change
    create_table :choice_answers do |t|
      t.references :user, null: false, foreign_key: true
      t.references :choice, null: false, foreign_key: true

      t.timestamps
    end
  end
end
