#require 'harvest'
#require Rails.root.join('app/jobs', 'sleeper')

class Query < ApplicationRecord
   after_create :start_job
   after_save :check_for_finish

   belongs_to :search
   has_many :tweets




   def start_job
     #byebug
     Timber.with_context(app: {name: "bot-tracker", env: Rails.env}) do
       Rails.logger.info "Adding Twitter Query to Queue... id: #{self.id} keyword: #{self.keyword}"
     end
     #
     Resque.enqueue(Harvest::TwitterWorker, self.id, self.keyword)
     #Harvest::TwitterWorker.perform(self.id, self.keyword)

   end

   def check_for_finish

     count = 0
     self.search.queries.each do |query|
       if query.status == "done"
         count +=1
       end
     end
     #finished_count = Query.where(status: "done").where(search_id: self.search.id).count
     if count === self.search.queries.count
       self.search.status = 'finished'
       self.search.save
     end
   end

   def stop_job
     #byebug
    if self.search.status != 'finished'
      Resque::Job.destroy(:harvest, Harvest::TwitterWorker, self.id, self.keyword)
      self.search.status = 'stopped'
      self.search.save
    end
  end

end
