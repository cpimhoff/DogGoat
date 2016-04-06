class AccountMailer < ApplicationMailer

  def password_recovery(member, new_password)
    @member = member
    @new_password = new_password
    self.attach_layout_resources
    mail to: @member.email, subject: "DogGoat Password Recovery"
  end
end
