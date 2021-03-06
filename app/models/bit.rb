class Bit < ActiveRecord::Base

  belongs_to :author, class_name: "Member", foreign_key: "author_id"

  validates_presence_of :author_id, message: "Bits must have an authoring member."
  validates_presence_of :raw_content, message: "Bits need content."
  validates_length_of :raw_content, maximum: 400, message: "This bit is pretty long. Could you reduce it a ... bit? Or turn it into a Post?"
  validates_presence_of :color, message: "Bits need to have a color value. It makes the site more approachable."

  scope :by_recent, -> {order('created_at DESC')}
  scope :by_time_score, -> {order('time_score DESC')}

  paginates_per 8

  def content
    return self.raw_content
  end

  def upvote
    new_score = self.time_score + 1.hours
    if new_score > Time.now
      new_score = Time.now
    end
    self.time_score = new_score
  end

end
