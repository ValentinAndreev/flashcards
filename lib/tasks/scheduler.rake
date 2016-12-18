task send_reminders: :environment do
  User.send_email
end