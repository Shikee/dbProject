class CreateWorksFors < ActiveRecord::Migration[5.0]
  def change
    create_table :works_fors do |t|
      t.integer :user_id,  :null => false
      t.integer :mentorgroup_id,  :null => false
      t.integer :category_id, :null=>false
      t.timestamps
    end
  end
end
