class MakeClaimCodesPlainText < ActiveRecord::Migration

  def change
    add_column :invites, :claim_code, :string, :limit => 10
  end

end
