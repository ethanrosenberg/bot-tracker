
module Harvest

  SLEEP = 7

  class Twitter

    @queue = :harvest

    def initialize(query_id, keyword)

      @query_id = query_id
      @query_keyword = keyword
      @query = Query.find(query_id)
      @sleep = SLEEP

    end

    def self.perform(query_id, keyword)
      #search = Search.create(status: 'working')
      puts "queryid: #{query_id} keyword: #{keyword}"
     Harvest::Twitter.new(query_id, keyword).start
    end

    def start
      5.times do |item|
        #byebug
        puts "Sleeping for 10 seconds."
        sleep 10

      end

      puts "Finished harvest."
      #@word.finish
    end

  end
end
