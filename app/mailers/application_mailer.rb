class ApplicationMailer < ActionMailer::Base
  DEFAULT_MAIL_FROM = 'kmet.admin@ukr.net'
  default from: DEFAULT_MAIL_FROM
  layout 'mailer'
end
