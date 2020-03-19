#require 'byebug'

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
      STDERR.puts "queryid: #{query_id} keyword: #{keyword}"

      Harvest::Twitter.new(query_id, keyword).start
    end

    def start

      #byebug

      unless @query.search.status == 'finished' || @query.search.status == 'stopped'
        STDERR.puts "scraping keyword: #{@query_keyword}"
        STDERR.puts "zzzzz... 15 seconds."

        sleep 30
      end




      puts "Finished harvest."
      #@word.finish
    end

  end

end
