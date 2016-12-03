class ChangeAssignToQuestion < ActiveRecord::Migration[5.0]
  def change
      change_column :questions, :assign, :integer , :default=>0

  end
end
