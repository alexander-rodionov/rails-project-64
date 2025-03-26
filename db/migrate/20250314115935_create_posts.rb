class CreatePosts < ActiveRecord::Migration[7.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.references :category, null: false, foreign_key: true
      t.text :body
      t.references :creator, null: false, foreign_key: { to_table: :users }
      t.string :status

      t.timestamps
    end
  end
end
