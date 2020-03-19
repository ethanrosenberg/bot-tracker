module Harvest

  class Twitter
    @queue = :harvest

    def initialize(query_id, keyword)

      @query_id = query_id
      @query_keyword = keyword
      @query = Query.find(query_id)
      @sleep = 7

    end

    def self.perform(query_id, keyword)
      #search = Search.create(status: 'working')
      puts "queryid: #{query_id} keyword: #{keyword}"
      Harvest.new(query_id, keyword).start
    end

    def start

        puts "scraping keyword: #{@query_keyword}"
        puts "zzzzz... 10 seconds."
        sleep 15


      puts "Finished harvest."
      #@word.finish
    end

  end

end
