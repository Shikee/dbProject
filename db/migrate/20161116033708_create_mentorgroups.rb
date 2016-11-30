class CreateMentorgroups < ActiveRecord::Migration[5.0]
  def change
    create_table :mentorgroups do |t|
      t.string :name
      t.integer :user_id
      t.integer :category_id
      t.timestamps
    end
  end
end
