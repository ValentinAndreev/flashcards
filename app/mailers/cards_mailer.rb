# Mailer
class CardsMailer < ApplicationMailer
  def pending_cards_notification(emails)
    mail(to: emails, subject: "Time to check your cards")
  end
end
