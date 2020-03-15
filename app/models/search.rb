class Search < ApplicationRecord
  after_create :start_jobs

  def start_jobs

    STDERR.puts "starting twitter scraper..."
    #Scrape::Twitter.scrape

    mark_finished

  end

  def scrape_tweets(keyword, client)

    client.search(keyword).take(5).each do |tweet|

      Tweet.create do |t|
        #t.tweet_id = tweet.id
        t.text = tweet.text
        t.created_at = tweet.created_at
        #t.user_id = tweet.user.id
        t.profile_created_at = tweet.user.created_at
        t.profile_handle = tweet.user.screen_name
        t.profile_image_url = tweet.user.profile_image_url_https.to_s
        t.followers = tweet.user.followers_count
      end

    end

  end

  def mark_finished
    self.status = 'finished'
    save
  end

end
