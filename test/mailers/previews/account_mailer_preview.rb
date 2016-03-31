# Preview all emails at http://localhost:3000/rails/mailers/account_mailer
class AccountMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/account_mailer/password_recovery
  def password_recovery
    AccountMailer.password_recovery(Member.first, "NEW_PASSWORD")
  end

end
