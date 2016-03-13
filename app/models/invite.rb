require 'bcrypt'

class Invite < ActiveRecord::Base

  belongs_to :owner, class_name: "Member", foreign_key: "owner_id"

  EMAIL_RX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates_uniqueness_of :claim_code_hash
  validates_presence_of :owner_id, message: "Invites must be sent by a valid member."
  validates_presence_of :claimed

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_format_of :email, with: EMAIL_RX, message: "Please provide a valid email address."
  validates_confirmation_of :email

  include BCrypt

  def claim_code
    @claim_code ||= Password.new(self.claim_code_hash)
  end

  #Verify with 'claim_code == attempted_code'

  def claim_code=(new_code)
    @claim_code = Password.create(new_code)
    self.claim_code_hash = @claim_code
  end

end
