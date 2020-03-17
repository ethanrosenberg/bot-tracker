# config/initializers/resque.rb
require 'resque/server'
require 'resque/failure/multiple'
require 'resque/failure/redis'
require 'resque/failure/airbrake'

  uri = URI.parse(ENV['REDISTOGO_URL'])
  REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)

  Resque.redis = REDIS



Resque::Failure::Multiple.classes = [Resque::Failure::Redis, Resque::Failure::Airbrake]
Resque::Failure.backend = Resque::Failure::Multiple