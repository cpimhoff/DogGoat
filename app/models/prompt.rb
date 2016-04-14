class Prompt < ActiveRecord::Base

  has_many :riffs, foreign_key: "prompt_id"
  belongs_to :author, class_name: "Member", foreign_key: "author_id"

  validates_presence_of :title, message: "Prompts must have a title."
  validates_presence_of :author_id, message: "Prompts must have an authoring member."
  validates_presence_of :color, message: "Prompts have to have a color value. It makes the site more approachable."

  validates_length_of :text, minimum: 5, message: "Prompts should prompt."
  validates_length_of :text, maximum: 150, message: "Prompts should be short and snappy."

  paginates_per 6

  scope :by_recent, -> {order('created_at DESC')}

  # returns a list of a few riffs, which should be voted on
  def voting_selection
    return self.riffs.limit(3).randomly
  end

  def is_open
    if Time.now > self.end_time
      return false
    else
      return true
    end
  end

  def end_time
    return self.created_at.tomorrow # for now, all Riff durations are one day
  end

  def has_member_contributed(member_id)
    contrib = self.riffs.where(:author_id == :member_id)
    if contrib.count > 0
      return true
    else
      return false
    end
  end

  include FriendlyId
  friendly_id :slug_candidates, :use => :slugged
  def slug_candidates
    [
      :title,
      "#{self.title} from #{self.author.full_name}",
      [:title, :id]
    ]
  end

end
