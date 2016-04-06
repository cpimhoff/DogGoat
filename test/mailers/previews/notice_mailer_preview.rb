# Preview all emails at http://localhost:3000/rails/mailers/notice_mailer
class NoticeMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/notice_mailer/call_for_posts
  def call_for_posts
    NoticeMailer.call_for_posts(Member.first)
  end

end
