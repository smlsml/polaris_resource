class CreatePurchases < ActiveRecord::Migration
  def self.up
    create_table :purchases do |t|
      t.timestamps
      t.integer :item_id
    end
    add_index :purchases, :item_id
  end

  def self.down
    drop_table :purchases
  end
end
