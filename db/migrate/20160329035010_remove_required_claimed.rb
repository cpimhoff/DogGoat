class RemoveRequiredClaimed < ActiveRecord::Migration
  def change
    remove_column :invites, :claimed
    add_column :invites, :claimed, :boolean, default: false
  end
end
