require 'rubygems'

# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __FILE__)
ENV['RAB_PUB_ENV'] ||= 'development'

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

if defined?(Bundler)
  Bundler.require(:default, ENV['RAB_PUB_ENV'])
end


CONFIG = Mostash.new

CONFIG.env = ENV['RAB_PUB_ENV']

unless CONFIG.env == 'production'
  require 'dotenv'
  Dotenv.load
end

CONFIG.rabbit = {
  :enabled => ENV['WITHOUT_RABBIT'] || true,
  :broker => {
    :url => ENV['CLOUDAMQP_URL'] || (raise Exception.new('CLOUDAMQP_URL must be set as env variable'))
  },
  :outbound => {
    :exchange => {
      :name => "#{CONFIG.env.upcase}.TEST_MESSAGE",
      :opts => {
        :type => :fanout,
        :durable => true
      }
    }
  }
}

set :environment, CONFIG.env.to_sym

require File.expand_path('../lib/rabpub.rb', __FILE__)
RabPubApplication.run! if $0 =~  /web_runner.rb$/
