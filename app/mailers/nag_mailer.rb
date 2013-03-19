class NagMailer < ActionMailer::Base
  default from: "nagitive@gmail.com"

  def nag_borrower(nag)
    @nag = nag
    mail to: @nag.user.email, subject: "give me my shiz back", template_path: 'nag_mailer'
  end
  def expiring_token_notification(user)
    @user = user
    mail to: user.email, subject: "Log Back In", template_path: 'nag_mailer'
  end
end
