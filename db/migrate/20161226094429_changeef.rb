class Changeef < ActiveRecord::Migration
  def change
    remove_column :users, :ef, :float, default: 2.5
    add_column :cards, :ef, :float, default: 2.5
  end
end
