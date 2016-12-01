class AddImageToCards < ActiveRecord::Migration
  def change
  	add_attachment :cards, :image
  end
end
