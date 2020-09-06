class NotificationFromAdminJob < ApplicationJob
  queue_as :default
  def perform(msg)
   User.all.each do |user|
    NotificationFromAdminMailer.notify(user, msg).deliver_later
   end
      # Jobのときは絶対描かなきゃいけない
      # deliver_later
  end
end