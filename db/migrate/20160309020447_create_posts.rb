class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title, default: "", null: false
      t.string :color
      t.text :content, default: "", null: false
      t.integer :view_count, default: 0, null: false

      t.integer :author_id, null: false

      t.timestamps null: false
    end
  end
end
