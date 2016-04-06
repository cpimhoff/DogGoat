class NoticeMailer < ApplicationMailer

  def call_for_posts(member)
    @member = member
    self.attach_layout_resources
    mail to: @member.email, subject: "Post to DogGoat!"
  end

  def send_notice_call_for_posts_to_members(members)
    for m in members
      call_for_posts(m)
    end
  end
  
end
