# Mailer
class CardsMailer < ApplicationMailer
  default to: Proc.new { User.notifications_list.pluck(:email) },
  from: 'valentinandreev80@gmail.com'
 
  def pending_cards_notification
    mail(subject: "Time to check your cards")
  end
end
