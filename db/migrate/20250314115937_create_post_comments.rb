# frozen_string_literal: true

class CreatePostComments < ActiveRecord::Migration[7.2]
  def change
    create_table :post_comments do |t|
      t.string :ancestry, null: false
      t.text :content

      t.timestamps

      t.references :user, null: false, foreign_key: { to_table: :users }
      t.references :post, null: false, foreign_key: true
    end
    add_index :post_comments, :ancestry
  end
end
