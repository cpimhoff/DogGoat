class Riff < ActiveRecord::Base

  belongs_to :author, class_name: "Member", foreign_key: "author_id"
  belongs_to :prompt, class_name: "Prompt", foreign_key: "prompt_id"

  validates_presence_of :author_id, message: "Riffs must have an authoring member."
  validates_length_of :content, maximum: 200, message: "This riff is pretty long. Make it short and snappy!"
  validates_numericality_of :votes, greater_than_or_equal_to: 0, only_integer: true, message: "Prompts can't have fewer than zero votes."

  scope :by_recent, -> {order('created_at DESC')}
  scope :by_vote, -> {order('votes DESC')}

end
