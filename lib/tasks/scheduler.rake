desc "Send updates to all users"
task :send_all_updates => :environment do
  User.connection

  User.all.each do |u|
    u.send_message
  end
end
