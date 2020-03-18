require 'resque/tasks'
require Rails.root.join('lib', 'harvest')
#require Rails.root.join('lib', 'harvest')

task "resque:preload" => :environment
task "resque:setup" => :environment
