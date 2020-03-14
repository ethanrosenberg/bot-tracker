require 'open-uri'
require 'nokogiri'
require 'twitter'
require 'json'



class SearchesController < ApplicationController

  AGENT   = "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:9.0.1) Gecko/20100101 Firefox/9.0.1"

  def scrape

    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["CONSUMER_KEY"]
      config.consumer_secret     = ENV["CONSUMER_SECRET"]
      config.access_token        = ENV["ACCESS_TOKEN"]
      config.access_token_secret = ENV["ACCESS_SECRET"]
    end



    client.search('americanbulldog').take(3).each do |tweet|
      byebug
      tweet_id = tweet.id
      tweet_text = tweet.text
      tweet_created_at = tweet.created_at
      user_id = tweet.user.id
      profile_created_at = tweet.user.created_at
      handle = tweet.user.screen_name
      profile_image_url = tweet.user.profile_image_url_https.to_s
      followers = tweet.user.followers_count

      puts tweet.inspect
    end

    byebug
  end

  def start


    task = crawl_url("https://twitter.com/search?q=americanbulldog%20since%3A2015-05-01%20until%3A2015-05-05")

    #html =  File.read('sample.html')
    nok = Nokogiri::HTML.parse(task)
    #nok.xpath("//table[@class='tweet-container']")

    puts "First batch..."
    puts " "
    first_id = ""
    last_id = ""
    length = nok.xpath("//table[@class='tweet  \']").length
    index = 1

    nok.xpath("//table[@class='tweet  \']").each do |tweet|
      #<tr class=\"tweet-container\">\# NOTE:
      #tweet_text = tweet.text.strip

      tweet_url = "https://twitter.com/" + tweet.attr('href')
      profile_pic = tweet.xpath(".//img").attr('src').value
      handle = tweet.xpath(".//td[@class='user-info\']//a").attr('href').value.chomp("?p=s").to_s
      tweet_content = tweet.xpath(".//tr[@class='tweet-container\']").text.strip
      id = tweet.xpath(".//div[@class='tweet-text\']").attr('data-id').value


      if index === 1
        first_id = id
      elsif index === length
        last_id = id
      end

      index += 1

      puts "Handle - " + handle
      puts "Tweet >> " + tweet_content
      puts "ID - " + id
      puts " "

    end


     puts "Second batch..."
     index = 1
     first_id = ""
     last_id = ""
     second_url = "https://twitter.com/i/search/timeline?vertical=default&q=americanbulldog%20since%3A2015-05-01%20until%3A2015-05-05&include_available_features=1&include_entities=1&max_position=TWEET-#{first_id}-#{last_id}&reset_error_state=false"
     second = crawl_url(second_url)

     resp = JSON.parse(second)
     second_html = Nokogiri::HTML.parse(resp["items_html"])

     #html =  File.read('sample.html')
     #nok = Nokogiri::HTML.parse(task)

     second_html.xpath("//li[@class='js-stream-item stream-item stream-item\n\']").each do |item|
       id = item.attr('data-item-id')

       if index === 1
         first_id = id
       elsif index === length
         last_id = id
       end

       index += 1

     end

     byebug

  end

  def clean_content(html)
    html = raw_html.encode('UTF-8', invalid: :replace, undef: :replace, replace: '', universal_newline: true).gsub(/\P{ASCII}/, '')
    parser = Nokogiri::HTML(html, nil, Encoding::UTF_8.to_s)
    parser.xpath('//script')&.remove
    parser.xpath('//style')&.remove
    parser.xpath('//text()').map(&:text).join(' ').squish
  end

  def crawl_url(url)

#https://twitter.com/search?q=americanbulldog%20since%3A2015-05-01%20until%3A2015-05-05

    return open(url,"User-Agent" => 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:9.0.1) Gecko/20100101 Firefox/9.0.1').read.to_s

            #:proxy => "http://69.46.80.226:19403").read.to_s

    #open("https://twitter.com/search?q=americanbulldog%20since%3A2015-05-01%20until%3A2015-05-05",
            # {"User-Agent" => AGENT,
            #   "Referer"    => "twitter.com" }) do |f|
          #return f.read.to_s
  end


end
