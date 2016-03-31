class AccountMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #   en.account_mailer.password_recovery.subject
  def password_recovery(member, new_password)
    @member = member
    @new_password = new_password
    mail to: @member.email
  end
end
