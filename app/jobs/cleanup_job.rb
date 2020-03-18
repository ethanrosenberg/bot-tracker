class CleanupJob < ApplicationJob
  queue_as :harvest

  def perform(*args)
    # Do something later
      5.times do |item|
        #byebug
        puts "Sleeping for 10 seconds."
        sleep 10

      end
  end
end
