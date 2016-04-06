class NoticeMailer < ApplicationMailer

  def call_for_posts(member)
    @member = member
    self.attach_layout_resources
    mail to: @member.email, subject: "Post to DogGoat!"
  end

end
