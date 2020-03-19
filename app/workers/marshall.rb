class Marshall
  include Sidekiq::Worker

  def perform(name = "Ethan")
    # do something
    5.times do |item|
      #byebug
      puts "Sleeping #{name} for 10 seconds."
      sleep 10

    end

  end
end
