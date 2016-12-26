class AddQ < ActiveRecord::Migration
  def change
    add_column :cards, :q, :integer 	
  end
end
