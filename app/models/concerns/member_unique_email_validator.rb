# Validates that members change their emails to eligibal emails:
class MemberUniqueEmailValidator < ActiveModel::Validator

  def validate(record)
    members = Member.where(email: record.email)
    members.each do |m|
      if m.id != record.id
        # This email is not our record and has already joined DogGoat
        record.errors.add :email, "This email is already in use by another Member"
        return
      end
    end
    invite = Invite.where(email: record.email).first
    if invite.present?
      if invite.claimed == false || invite.claimed == nil
        # The email has been invited (and yet to be claimed):
        record.errors.add :email, "A person at this address has been invited to DogGoat by #{invite.owner.full_name}"
      end
    end
  end

end
