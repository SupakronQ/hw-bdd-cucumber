class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.text :comments
      t.integer :potatoes
      t.references :movie
      t.references :moviegoer

      t.timestamps null: false
    end
  end
end
