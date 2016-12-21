# Mailer
class CardsMailer < ApplicationMailer
  default to: Proc.new { User.pluck(:email) },
  from: 'valentinandreev80@gmail.com'
 
  def pending_cards_notification(user)
    mail(subject: "Time to check your cards")
  end
end
