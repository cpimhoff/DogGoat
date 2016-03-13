class Post < ActiveRecord::Base

  belongs_to :author, class_name: "Member", foreign_key: "author_id"

  validates_presence_of :title, message: "Please give your post a catchy title."
  validates_presence_of :author_id, message: "Posts must have an authoring member."
  validates_presence_of :color, message: "Posts have to have a color value. It makes the site more approachable."
  validates_presence_of :raw_content, message: "Looks like you forgot to write something here..."
  validates_length_of :raw_content, minimum: 300, message: "Your post isn't very long. We'd appreciate it if you could expand on it."
  validates_numericality_of :view_count

  scope :recent, -> {order('created_at DESC').visible}
  scope :hot, -> {order('view_count DESC').visible}
  scope :cold, -> {order('view_count ASC').visible}
  scope :visible, -> {where('hidden'=> false)}

  def content
    renderer = Redcarpet::Render::HTML.new(escape_html: true)
    md = Redcarpet::Markdown.new(renderer, no_intra_emphasis: true, autolink: true, strikethrough: true, lax_spacing: true)
    return md.render(self.raw_content)
  end

end
