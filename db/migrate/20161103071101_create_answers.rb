class CreateAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :answers do |t|
      t.string :title
      t.text :content
      t.integer :question_id
      t.integer :user_id
      t.datetime :rate_due

      t.timestamps
    end
  end
end
