class CreateRiffs < ActiveRecord::Migration
  def change
    create_table :riffs do |t|

      t.timestamps null: false
    end
  end
end
