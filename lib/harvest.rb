
module Harvest

  SLEEP = 7

  class Twitter

    @queue = :harvest

    def initialize(search_id, q)

      @query_keywords    = Keyword.all
      #@search = Search.find(search_id)
      #@search_id = search_id
      @sleep     = Harvest::SLEEP

    end

    def self.perform(search_id, query)
     Harvest::Twitter.new(search_id, query).start
    end

    def start
      while (@search.status !== 'stopped') do
        puts "Searching..."
        sleep @sleep.seconds
      end
      #@word.finish
    end

  end
end
