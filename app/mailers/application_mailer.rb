class ApplicationMailer < ActionMailer::Base
  default from: ENV['gmail_address']
  layout 'mailer'
end
