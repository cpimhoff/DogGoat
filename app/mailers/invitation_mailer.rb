class InvitationMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #   en.invitation_mailer.welcome.subject
  def welcome(invite)
    @invite = invite
    mail to: invite.email
  end
end
