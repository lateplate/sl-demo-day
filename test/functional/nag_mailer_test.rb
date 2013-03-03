require 'test_helper'

class NagMailerTest < ActionMailer::TestCase
  test "nag_borrower" do
    mail = NagMailer.nag_borrower
    assert_equal "Nag borrower", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
