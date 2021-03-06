env :PATH, ENV['PATH']
env :GEM_PATH, ENV['GEM_PATH']
# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
  set :output, "/home/z/Rails/flashcards/cron_log.log"
  set :environment, "development"
  every :day do
    runner "User.send_email"
  end
  

# Learn more: http://github.com/javan/whenever
