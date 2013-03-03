class NagMailer < ActionMailer::Base
  default from: "nagitive@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.nag_mailer.nag_borrower.subject
  #
  def nag_borrower(nag)
    @nag= nag
    mail to: nag.lendee_name, subject: "give me my shiz back"
  end
end
