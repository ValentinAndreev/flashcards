class AddStageToCard < ActiveRecord::Migration
  def change
    add_column :cards, :right_checks, :integer
    add_column :cards, :wrong_checks, :integer    
  end
end
