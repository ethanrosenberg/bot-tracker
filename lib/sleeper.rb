
  module Sleeper

    class Work
    @queue = :harvest

      def self.perform(seconds)

        10.times do |item|
          puts "Sleeping for #{seconds} seconds."
          sleep seconds
        end

        puts "Finished harvest."
      end
  end

end
