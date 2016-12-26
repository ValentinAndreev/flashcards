class AddEf < ActiveRecord::Migration
  def change
    add_column :users, :ef, :float, default: 2.5
  end
end
