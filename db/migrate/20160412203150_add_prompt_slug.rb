class AddPromptSlug < ActiveRecord::Migration
  def change
    add_column :prompts, :slug, :string
    add_index :prompts, :slug, :unique => true
  end
end
