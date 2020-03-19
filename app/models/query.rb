#require 'harvest'
#require Rails.root.join('app/jobs', 'sleeper')

class Query < ApplicationRecord
   after_create :start_job
   belongs_to :search


   #include Harvest

   def start_job
     #byebug
     STDERR.puts "queueing twittery query... id: #{self.id} keyword: #{self.keyword}"
     Resque.enqueue(self.id, Harvest::Twitter)

   end

end
