require 'open-uri'
require 'nokogiri'

class SearchesController < ApplicationController

  AGENT   = "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:9.0.1) Gecko/20100101 Firefox/9.0.1"

  def start


    task = crawl_url("")

    #html =  File.read('sample.html')
    nok = Nokogiri::HTML.parse(task)
    #nok.xpath("//table[@class='tweet-container']")

    nok.xpath("//table[@class='tweet  \']").each do |tweet|
      #<tr class=\"tweet-container\">\# NOTE:
      #tweet_text = tweet.text.strip
      tweet_url = "https://twitter.com/" + tweet.attr('href')
      profile_pic = tweet.xpath(".//img").attr('src').value
      handle = tweet.xpath(".//td[@class='user-info\']//a").attr('href').value.chomp("?p=s")
      tweet_content = tweet.xpath(".//tr[@class='tweet-container\']").text.strip
      puts "Handle - " + handle.chomp("?p=s")
      puts "Tweet >> " + tweet_content
      puts " "

    end





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

    return open("https://twitter.com/search?q=americanbulldog%20since%3A2015-05-01%20until%3A2015-05-05",
            "User-Agent" => 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:9.0.1) Gecko/20100101 Firefox/9.0.1').read.to_s

            #:proxy => "http://69.46.80.226:19403").read.to_s

    #open("https://twitter.com/search?q=americanbulldog%20since%3A2015-05-01%20until%3A2015-05-05",
            # {"User-Agent" => AGENT,
            #   "Referer"    => "twitter.com" }) do |f|
          #return f.read.to_s
  end


end
