class Post < ActiveRecord::Base

  belongs_to :author, class_name: "Member", foreign_key: "author_id"

  # critical validations
  validates_presence_of :title, message: "Please give your post a catchy title."
  validates_length_of :title, maximum: 35, message: "This title is too long."
  validates_presence_of :author_id, message: "Posts must have an authoring member."
  validates_numericality_of :view_count

  # posting validations
  validates_presence_of :color, message: "Posts have to have a color value. It makes the site more approachable.", unless: :is_draft
  validates_length_of :raw_content, minimum: 300, message: "Your post isn't very long. We'd appreciate it if you could expand on it.", unless: :is_draft

  paginates_per 4

  scope :by_recent, -> {order('created_at DESC')}
  scope :by_hot, -> {order('view_count DESC')}
  scope :by_cold, -> {order('view_count ASC')}
  scope :featured, -> {where(featured: true)}

  scope :drafts_first, -> {order('is_draft DESC')}

  scope :visible, -> {where(hidden: false).published}
  scope :published, -> {where(is_draft: false)}

  def self.search(raw_query)
    query = raw_query.sub(" ", "%")
    query = "%#{query}%"
    return Post.joins(:author).where{(title =~ query) |
      ((members.first_name.op('||', ' ').op('||', members.last_name)) =~ query)}
    # return Post.joins(:author).where("title LIKE :query OR members.first_name || ' ' || members.last_name LIKE :query", {:query => "%#{query}%"})
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
