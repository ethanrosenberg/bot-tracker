#require 'harvest'

class Query < ApplicationRecord
   after_create :start_job
   belongs_to :search

   #include Harvest

   def start_job
     #byebug
     STDERR.puts "queueing twittery query... id: #{self.id} keyword: #{self.keyword}"
     Resque.enqueue(Harvest::Twitter, self.id, self.keyword)
   end

end
