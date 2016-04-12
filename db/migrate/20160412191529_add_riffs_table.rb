class AddRiffsTable < ActiveRecord::Migration

  def change
    create_table :riffs do |t|
      t.text :content, default: "", null: false
      t.integer :votes, default: 0, null: false
      t.boolean :is_winner, default: false, null: false

      t.integer :author_id, null: false
      t.integer :prompt_id, null: false

      t.timestamps null: false
    end
  end

end
