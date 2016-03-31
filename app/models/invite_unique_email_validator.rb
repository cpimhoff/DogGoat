# Validates that invites are sent to eligibal emails:
class InviteUniqueEmailValidator < ActiveModel::Validator

  def validate(record)
    member = Member.where(email: record.email).first
    if member.present?
      # The email has already joined DogGoat
      record.errors.add :email, "The person at this address is already a Member of DogGoat"
      return
    end
    invites = Invite.where(email: record.email)
    invites.each do |i|
      if i.id != record.id
        if i.claimed == false || i.claimed == nil
          # The email has been invited:
          record.errors.add :email, "The person at this address has already been invited to DogGoat by #{i.owner.full_name}"
        end
      end
    end
  end

end
