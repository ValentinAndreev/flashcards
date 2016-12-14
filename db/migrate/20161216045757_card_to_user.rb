class CardToUser < ActiveRecord::Migration
  def change
  	remove_column :cards, :user_id, :integer
  	add_reference :cards, :user, index: true, foreign_key: true
  end
end
