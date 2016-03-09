class Member < ActiveRecord::Base

  has_many :posts, foreign_key: "author_id"
  has_many :invites, foreign_key: "owner_id"

  #adds password virtual attribute
  #adds confirmation validation on password
  has_secure_password

end
