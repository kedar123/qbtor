require File.expand_path('../boot', __FILE__)

require 'rails/all'
 require 'rubygems'
require 'actionwebservice'
 
# Auto-require default libraries and those for the current Rails environment.
Bundler.require :default, Rails.env

module Qbtoer
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Add additional load paths for your own custom dirs
    config.autoload_paths += %W( #{config.root}/lib )
    config.autoload_paths += %W( #{config.root}/app/reports )

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
    # config.i18n.default_locale = :de

    # Configure generators values. Many other options are available, be sure to check the documentation.
    # config.generators do |g|
    #   g.orm             :active_record
    #   g.template_engine :erb
    #   g.test_framework  :test_unit, :fixture => true
    # end

    config.secret_token = "k328924b24bkj2hsd7243b24sdim5409dffn34nj2k4b82b4b2487dsbf24l2b44"

       
       
    
    

    
    config.session_store :cookie_store,
      :key => '_qbtoer_session',
      :secret => 'k13b3189b13v350836mx08n2b1k4hv97db139sekj42j46fy4u23yseieu244'

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password, :password_confirmation, :account_number,
                             :raw_post_data, :question_1, :question_2, :answer_1,
                             :answer_2, :upload, :visible_txaction_ids, :answers,
                             :data, :cookies, :creds, :cc_number, :cc_month, :cc_year, :cc_type, :ccv_number]

    config.active_support.deprecation = :log

    config.active_record.include_root_in_json = false
    config.gem "jammit"



    def self.standalone?
      ENV['STANDALONE'] == '1'
    end
    
    # Load configuration files
    def config.from_file(file)
      super
      
      action_mailer.delivery_method = :smtp
      action_mailer.smtp_settings = smtp_settings.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
    end
    
    config.from_file 'settings.yml'
  end
end
 
