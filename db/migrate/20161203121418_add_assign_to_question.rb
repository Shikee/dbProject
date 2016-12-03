class AddAssignToQuestion < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :assign, :boolean , :default=>false

  end
end
