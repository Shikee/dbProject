class AddAgeToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :age, :integer , :default=>0
    add_column :users, :role, :string , :default=>"menti"
  end
end
