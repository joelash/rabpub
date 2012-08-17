require 'rubygems'

# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

ENV['RAB_PUB_ENV'] ||= 'development'
                                                                                                                                                                                                                                              
if defined?(Bundler)
  Bundler.require(:default, ENV['RAB_PUB_ENV'])
end

set :environment, ENV['RAB_PUB_ENV'].to_sym

require File.expand_path('../lib/rabpub.rb', __FILE__)
RabPubApplication.run! if $0 =~  /web_runner.rb$/
