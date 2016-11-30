class CreateQevals < ActiveRecord::Migration[5.0]
  def change
    create_table :qevals do |t|
      t.integer :user_id
      t.integer :question_id
      t.integer :rate

      t.timestamps
    end
  end
end
