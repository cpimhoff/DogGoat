class FixMigration < ActiveRecord::Migration
  def change
    remove_column :invites, :claim_code_hash
  end
end
