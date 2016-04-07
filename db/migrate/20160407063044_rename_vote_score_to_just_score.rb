class RenameVoteScoreToJustScore < ActiveRecord::Migration
  def change
    rename_column :posts, :vote_score, :score
  end
end
