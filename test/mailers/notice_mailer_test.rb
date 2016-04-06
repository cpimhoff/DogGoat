require 'test_helper'

class NoticeMailerTest < ActionMailer::TestCase
  test "call_for_posts" do
    mail = NoticeMailer.call_for_posts
    assert_equal "Call for posts", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
