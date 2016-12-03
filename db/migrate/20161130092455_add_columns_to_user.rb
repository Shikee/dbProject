class AddColumnsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :question_count, :integer , :default=>0
    add_column :users, :answer_count, :integer , :default=>0
    add_column :users, :eval_count, :integer , :default=>0
    add_column :users, :heval_count, :integer , :default=>0
  end
end
