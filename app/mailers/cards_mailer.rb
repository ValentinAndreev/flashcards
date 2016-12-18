# Mailer
class CardsMailer < ApplicationMailer
  def pending_cards_notification(user)
    mail(to: user.email, subject: "Time to check your cards")
  end
end
