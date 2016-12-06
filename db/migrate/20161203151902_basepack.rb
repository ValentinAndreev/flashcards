class Basepack < ActiveRecord::Migration
  def change
  	add_column :packs, :base, :boolean, :default => false
  end
end
