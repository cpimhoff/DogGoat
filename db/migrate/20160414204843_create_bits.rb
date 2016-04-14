class CreateBits < ActiveRecord::Migration
  def change
    create_table :bits do |t|
      t.text :raw_content, default: "", null: false
      t.string :color
      t.integer :author_id, null: false

      t.timestamps null: false
    end
  end
end
