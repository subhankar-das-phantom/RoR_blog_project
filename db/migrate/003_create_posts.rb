class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.integer :status, default: 0
      t.string :slug
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    
    add_index :posts, :slug, unique: true
    add_index :posts, :status
    add_index :posts, :created_at
  end
end