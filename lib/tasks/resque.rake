require 'resque/tasks'
#require Rails.root.join('app/jobs', 'sleeper')
#require Rails.root.join('lib', 'harvest')

task "resque:setup" => :environment do
  #require Rails.root.join('lib', 'sleeper')
end

task "resque:preload" => :environment do
#  require Rails.root.join('lib', 'sleeper')

end

#task "resque:setup" => :environment
