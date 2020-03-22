# Load the Rails application.
require_relative 'application'
#require Rails.root.join("lib", "sleeper.rb")
# Initialize the Rails application.
#require Rails.root.join("lib", "sleeper")
#config.logger = RemoteSyslogLogger.new('logsN.papertrailapp.com', 514, :program => "rails-#{RAILS_ENV}")
#config.logger = RemoteSyslogLogger.new('logsN.papertrailapp.com', XXXXX)

Rails.application.initialize!
