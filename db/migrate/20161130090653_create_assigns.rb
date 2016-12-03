class CreateAssigns < ActiveRecord::Migration[5.0]
  def change
    create_table :assigns do |t|
      t.integer :question_id
      t.integer :user_id
      t.integer :mentorgroup_id

      t.timestamps
    end
  end
end
