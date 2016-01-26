class CreateUpvotes < ActiveRecord::Migration
  def change
    create_table :upvotes do |t|
      t.references :track
      t.references :user
      t.timestamps null: false
    end
    add_index :upvotes, :user_id
    add_index :upvotes, :track_id
  end
end
