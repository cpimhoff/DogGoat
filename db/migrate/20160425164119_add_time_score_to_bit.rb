class AddTimeScoreToBit < ActiveRecord::Migration
  def change
    add_column :bits, :time_score, :datetime, default: Time.now
  end
end
