class ApplicationJob < ActiveJob::Base
  queue_as :default
  handle_asynchronously :perform, :run_at => Proc.new {8.housrs.from_now}

  def perform user
    UserMailer::send_mail_every_months(user).deliver
  end
end


