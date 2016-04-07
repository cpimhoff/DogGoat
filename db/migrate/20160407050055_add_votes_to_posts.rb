class AddVotesToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :vote_score, :integer, default: 0
  end
end
