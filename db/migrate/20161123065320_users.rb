class Users < ActiveRecord::Migration
  def change
    add_belongs_to :cards, :users
  end
end
