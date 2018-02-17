class Signup < ActionMailer::Base
  default from: 'no-reply@colcho.net'
  #layout 'mailer'

  def confirm_email(user)
  	@user = user

  	@confirmation_link = confirmation_url({token: @user.confirmation_token})

  	mail({
  				to: user.email,
   				bcc: ['Sign Ups <signups@colcho.net>'],
  				subject: I18n.t('signup.confirm_email.subject')
  			})
  end
end
