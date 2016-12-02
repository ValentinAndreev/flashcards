class CreatePacks < ActiveRecord::Migration
  def change
    create_table :packs do |t|
      t.string :title
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
