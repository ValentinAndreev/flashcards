class AddImageToCard < ActiveRecord::Migration
  def change
  	add_attachment :cards, :image
  end 
end
