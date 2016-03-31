# Validates that invites are sent to eligibal emails:
class InviteUniqueEmailValidator < ActiveModel::Validator

  def validate(record)
    member = Member.where(email: record.email).first
    if member.present?
      # The email has already joined DogGoat
      record.errors.add :email, "The person at this address is already a Member of DogGoat"
      return
    end
    invite = Invite.where(email: record.email).first
    if invite.present?
      # The email has been invited:
      record.errors.add :email, "The person at this address has already been invited to DogGoat by #{invite.owner.full_name}"
    end
  end

end
