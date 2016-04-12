class Prompt < ActiveRecord::Base

  has_many :riffs, foreign_key: "prompt_id"
  belongs_to :author, class_name: "Member", foreign_key: "author_id"

  validates_presence_of :author_id, message: "Prompts must have an authoring member."
  validates_presence_of :color, message: "Prompts have to have a color value. It makes the site more approachable."

  validates_length_of :text, maximum: 150, message: "Prompts should be short and snappy."

  paginates_per 6

  scope :by_recent, -> {order('created_at DESC')}

  # TODO: implement this
  def is_open
    return true
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
