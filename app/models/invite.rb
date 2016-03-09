require 'bcrypt'

class Invite < ActiveRecord::Base

  belongs_to :owner, class_name: "Member", foreign_key: "owner_id"

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
