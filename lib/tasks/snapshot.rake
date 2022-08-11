namespace :data do
    desc "This task does nothing"
    task :reset_polls => :environment do
      puts "reset Polls"
    #   binding.pry
      PollCampaign.delete_all
    end
  end