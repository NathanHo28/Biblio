class UserMailer < ActionMailer::Base
  default from: "helping_hand@biblio.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.reset_password_email.subject
  #
  def reset_password_email(user)
    @user = user
    @url = edit_password_reset_url(user.reset_password_token)

    mail(:to => user.email,
         :subject => "Biblio - Password Reset")
  end
end
