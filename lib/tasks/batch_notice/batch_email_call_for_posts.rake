
namespace :batch_notice do
  desc 'Sends an email to every member requesting them to post to the site'
  task :call_for_posts => :environment do
    all_members = Member.all
    for m in all_members
      puts "sending notice to: #{m.email}"
      NoticeMailer.call_for_posts(m).deliver
    end
  end
end
