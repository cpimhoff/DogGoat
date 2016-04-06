class InvitationMailer < ApplicationMailer

  def welcome(invite)
    @invite = invite
    self.attach_layout_resources
    mail to: invite.email, subject: "You've Been Invited to DogGoat"
  end
end
