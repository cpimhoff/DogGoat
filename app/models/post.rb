class Post < ActiveRecord::Base

  belongs_to :author, class_name: "Member", foreign_key: "author_id"

  validates_presence_of :title, message: "Please give your post a catchy title."
  validates_length_of :title, maximum: 35, message: "This title is too long."
  validates_presence_of :author_id, message: "Posts must have an authoring member."
  validates_presence_of :color, message: "Posts have to have a color value. It makes the site more approachable."
  validates_length_of :raw_content, minimum: 300, message: "Your post isn't very long. We'd appreciate it if you could expand on it."
  validates_numericality_of :view_count

  paginates_per 4

  scope :by_recent, -> {order('created_at DESC').visible}
  scope :by_hot, -> {order('view_count DESC').visible}
  scope :by_cold, -> {order('view_count ASC').visible}
  scope :featured, -> {where('featured'=> true).visible}
  scope :visible, -> {where('hidden'=> false)}

  def self.search(query)    # very basic search, only searches title
    return Post.where("title LIKE :query", {:query => "%#{query}%"})
  end

  def content
    renderer = Redcarpet::Render::HTML.new(escape_html: true)
    md = Redcarpet::Markdown.new(renderer, no_intra_emphasis: true, autolink: true, strikethrough: true, lax_spacing: true)
    return md.render(self.raw_content)
  end

  include FriendlyId
  friendly_id :slug_candidates, :use => :slugged
  def slug_candidates
    [
      :title,
      "#{self.title} by #{self.author.full_name}",
      [:title, :id]
    ]
  end

end
