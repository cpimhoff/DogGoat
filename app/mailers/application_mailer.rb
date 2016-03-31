class ApplicationMailer < ActionMailer::Base
  require 'mail'

  default from: "DogGoat <#{ENV['gmail_address']}>"
  layout 'mailer'

  def server_address
    email = ENV['gmail_address']
    name = "DogGoat"

    address = Mail::Address.new email
    address.display_name = name.dup
    address.format # returns "DogGoat <email>"
  end

end
