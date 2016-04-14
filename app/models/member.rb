class Member < ActiveRecord::Base

  has_many :posts, foreign_key: "author_id"
  has_many :prompts, foreign_key: "author_id"
  has_many :riffs, foreign_key: "author_id"
  has_many :bits, foreign_key: "author_id"
  has_many :invites, foreign_key: "owner_id"

  #adds password virtual attribute
  #adds confirmation validation on password
  has_secure_password

  EMAIL_RX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates_presence_of :first_name, message: "We'd love to get to know you on a first name basis. Our first name is Charlie."
  validates_length_of :first_name, maximum: 35
  validates_presence_of :last_name, message: "We need your last name. So we can make you sound professional."
  validates_length_of :last_name, maximum: 45
  validates_format_of :email, with: EMAIL_RX, message: "Please provide a valid email address."
  validates_confirmation_of :email, message: "Email confirmation must match"
  validates_numericality_of :invites_left, greater_than_or_equal_to: 0, only_integer: true
  validates_acceptance_of :terms_of_service # entirely virtual

  validates_with MemberUniqueEmailValidator

  def full_name
    return self.first_name + ' ' + self.last_name
  end

  include FriendlyId
  friendly_id :slug_candidates, :use => :slugged
  def slug_candidates
    [
      :full_name,
      [:full_name, :id]
    ]
  end

  def self.new_from_invite(invite)
    m = Member.new()
    m.first_name = invite.first_name
    m.last_name = invite.last_name
    m.email = invite.email
    return m
  end

end
