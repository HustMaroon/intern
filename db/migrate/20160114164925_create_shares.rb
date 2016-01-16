class CreateShares < ActiveRecord::Migration
  def change
    create_table :shares do |t|
      t.text :content
      t.references :user, index: true, foreign_key: true
      t.references :micropost, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :shares, [:user_id,:micropost_id, :created_at]
  end
end
