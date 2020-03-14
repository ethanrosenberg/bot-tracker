require 'open-uri'
require 'nokogiri'

class SearchesController < ApplicationController

  AGENT   = "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:9.0.1) Gecko/20100101 Firefox/9.0.1"

  def start

byebug
    task = crawl_url("")

    html =  File.read('sample.html')
    nok = Nokogiri::HTML.parse(html)
    #nok.xpath("//table[@class='tweet-container']")

    nok.xpath("//table[@class='tweet  \']").each do |tweet|
      #<tr class=\"tweet-container\">\n
      byebug

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

    return open(url,
            "User-Agent"=> 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:9.0.1) Gecko/20100101 Firefox/9.0.1',
            :proxy => "http://69.46.80.226:19403").read.to_s

    #open("https://twitter.com/search?q=americanbulldog%20since%3A2015-05-01%20until%3A2015-05-05",
            # {"User-Agent" => AGENT,
            #   "Referer"    => "twitter.com" }) do |f|
          #return f.read.to_s
  end


end
