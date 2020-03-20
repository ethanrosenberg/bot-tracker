require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BotTracker
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    #config.assets.enabled = true

    ## for using ActiveJob
    #config.active_job.queue_adapter = :resque

    #config.autoload_paths += %W(#{config.root}/app)

    #Spring.watch "app/jobs/**"

    #config.eager_load_paths << Rails.root.join('lib')
    #config.eager_load_paths << Rails.root.join('app/jobs')

    #autoloads lib & policy folder during development
    #config.autoload_paths << Rails.root.join('lib')
    config.autoload_paths += Dir["#{config.root}/lib/**/"]
    #config.autoload_paths << Rails.root.join('app/jobs')

    #onfig.autoload_paths << "#{Rails.root}/app/jobs"

    #ActiveSupport::Dependencies.autoload_paths.push "#{Rails.root}/app/lib"
    #ActiveSupport::Dependencies.autoload_paths.push "#{Rails.root}/app/jobs"
    config.eager_load_paths += [Rails.root.join('lib')]
    #config.autoload_paths << "#{Rails.root}/app/jobs"
    #config.autoload_paths += %W(#{Rails.root}/app/jobs)



    #config.eager_load_paths += %W(#{config.root}/lib)
    #config.autoload_paths << Rails.root.join('lib')
    #config.autoload_paths << Rails.root.join('lib/sleeper')
    #config.autoload_paths << Rails.root.join('lib')
    #config.autoload_paths << Rails.root.join('lib/scrape')
    #config.autoload_paths << Rails.root.join('lib/harvest')

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Don't generate system test files.
    config.generators.system_tests = nil
  end
end
