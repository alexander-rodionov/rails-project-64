# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration[7.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.string :status
      t.integer :likes_count, default: 0

      t.timestamps

      t.references :category, null: false, foreign_key: true
      t.references :creator, null: false, foreign_key: { to_table: :users }
    end
  end
end
