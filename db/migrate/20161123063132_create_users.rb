class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, limit: 30
      t.string :password, limit: 30

      t.timestamps null: false
    end
    add_index :users, :email, unique: true
  end
end
