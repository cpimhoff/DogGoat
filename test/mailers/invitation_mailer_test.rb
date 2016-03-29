require 'test_helper'

class InvitationMailerTest < ActionMailer::TestCase
  test "welcome" do
    mail = InvitationMailer.welcome
    assert_equal "Welcome", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
