set :environment, "development"

every 1.months do
  rake "send_mail:send_mail_every_months"
end
