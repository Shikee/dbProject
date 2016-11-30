class CreateHevals < ActiveRecord::Migration[5.0]
  def change
    create_table :hevals do |t|
      t.integer :question_id
      t.integer :user_id
      t.integer :question1
      t.integer :question2
      t.text :question3

      t.timestamps
    end
  end
end
