class CreateAevals < ActiveRecord::Migration[5.0]
  def change
    create_table :aevals do |t|
      t.integer :user_id
      t.integer :answer_id
      t.integer :ratepoint

      t.timestamps
    end
  end
end
