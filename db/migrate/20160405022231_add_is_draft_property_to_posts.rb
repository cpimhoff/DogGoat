class AddIsDraftPropertyToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :is_draft, :boolean, :default => false
  end
end
