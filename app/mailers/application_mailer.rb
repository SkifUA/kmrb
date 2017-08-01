class ApplicationMailer < ActionMailer::Base

  default from: Settings.mailer.user_name
  layout 'mailer'
end
