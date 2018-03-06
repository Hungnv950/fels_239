namespace :send_mail do
  desc "Send mail every month"
  task send_mail_every_months: :environment do
    users = User.all
    users.each do  user
      UserMailer::send_mail_every_months(user).deliver_later
    end
  end
end
