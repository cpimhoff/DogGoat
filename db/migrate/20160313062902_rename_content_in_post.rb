class RenameContentInPost < ActiveRecord::Migration
  def change
    rename_column :posts, :content, :raw_content
  end
end
