# Mailer
class CardsMailer < ApplicationMailer
  default from: 'valentinandreev@bk.ru'
 
  def pending_cards_notification(user)
    mail(to: user.email, subject: "Time to check your cards")
  end
end
