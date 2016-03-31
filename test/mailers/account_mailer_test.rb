require 'test_helper'

class AccountMailerTest < ActionMailer::TestCase
  test "password_recovery" do
    mail = AccountMailer.password_recovery
    assert_equal "Password recovery", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
