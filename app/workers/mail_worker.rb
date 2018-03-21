class MailWorker
  include Sidekiq::Worker

  def perform
    puts "woker"
  end
end
