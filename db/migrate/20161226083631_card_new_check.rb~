class CardNewCheck < ActiveRecord::Migration
  def change
    remove_column :cards, :right_checks, :integer
    remove_column :cards, :wrong_checks, :integer
    add_column :cards, :checks, :integer
  end
end
