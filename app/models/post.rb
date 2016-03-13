class Post < ActiveRecord::Base

  belongs_to :author, class_name: "Member", foreign_key: "author_id"

  scope :recent, -> {order('created_at DESC')}
  scope :hot, -> {order('view_count DESC')}
  scope :cold, -> {order('view_count ASC')}

  def content
    renderer = Redcarpet::Render::HTML.new(escape_html: true)
    md = Redcarpet::Markdown.new(renderer, no_intra_emphasis: true, autolink: true, strikethrough: true, lax_spacing: true)
    return md.render(self.raw_content)
  end

end
