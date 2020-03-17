
  class Harvest
    @queue = :harvest_queue

    def self.perform
      puts "AMAZING!!! IT WORKED!"
    end

  end
