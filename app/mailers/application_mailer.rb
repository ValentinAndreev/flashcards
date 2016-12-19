require 'dotenv'	

class ApplicationMailer < ActionMailer::Base

Dotenv.load(Rails.root.join('config', 'email.env'))	
ActionMailer::Base.smtp_settings = {
  user_name: ENV['MAIL_NAME'],
  password: ENV['MAIL_PASSWORD'],
  domain: 'mail.ru',
  address: 'smtp.mail.ru',
  port: 465,
  authentication: :plain,
  enable_starttls_auto: true
}
  layout 'mailer'
end
