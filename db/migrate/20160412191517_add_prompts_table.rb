class AddPromptsTable < ActiveRecord::Migration

  def change
    create_table :prompts do |t|
      t.string :title, default: "", null: false
      t.string :color
      t.text :text, default: ""
      t.integer :view_count, default: 0, null: false

      t.integer :author_id, null: false

      t.timestamps null: false
    end
  end

end
