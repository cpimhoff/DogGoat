class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :first_name, limit: 35
      t.string :last_name, limit: 45
      t.string :email, null: false
      t.integer :invites_left, default: 0, null: false

      t.string :password_digest

      t.timestamps null: false
    end
  end
end
