class ApplicationMailer < ActionMailer::Base

  default from: ENV['MAILER_USER_NAME'] || Settings.mailer.user_name
  layout 'mailer'
end
