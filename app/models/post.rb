class Post < ActiveRecord::Base

  belongs_to :author, class_name: "Member", foreign_key: "author_id"

  scope :recent, -> {order('created_at DESC')}
  scope :hot, -> {order('view_count DESC')}
  scope :cold, -> {order('view_count ASC')}

end
