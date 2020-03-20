#require 'harvest'
#require Rails.root.join('app/jobs', 'sleeper')

class Query < ApplicationRecord
   after_create :start_job
   belongs_to :search


   #include Harvest

   def start_job
     #byebug
     Rails.logger.info "Adding Twitter Query to Queue... id: #{self.id} keyword: #{self.keyword}"
     Resque.enqueue(Harvest::TwitterWorker, self.id, self.keyword)

   end

   def stop_job
     #byebug
    if self.search.status != 'finished'
      Resque::Job.destroy(:harvest, Harvest::TwitterWorker, self.id, self.keyword)
      self.search.status = 'finished'
      self.search.save
    end
  end

end
