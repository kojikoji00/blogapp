# rake task
namespace :notification do
  desc '利用者にメールを送付する'

  task :send_emails_from_admin, ['msg'] => :environment do |task, args|
    msg = args['msg']
    if msg.present?
      NotificationFromAdminJob.perform_later(msg)
    else
      
    end
    # adminからメールを送付する
    # args: arguments: 引数
  end
end