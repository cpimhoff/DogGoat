class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.string :claim_code_hash, null: false
      t.boolean :claimed, default: false, null: false

      t.string :email, null: false
      t.string :first_name, limit: 35
      t.string :last_name, limit: 45

      t.integer :owner_id

      t.timestamps null: false
    end
  end
end
