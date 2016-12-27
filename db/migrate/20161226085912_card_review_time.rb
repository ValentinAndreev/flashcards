class CardReviewTime < ActiveRecord::Migration
  def change
    add_column :cards, :review_time, :integer
  end
end
