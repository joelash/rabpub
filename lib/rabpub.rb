require 'sinatra_more/markup_plugin'
require 'sinatra_more/render_plugin'


require File.expand_path('../rabpub/routes.rb', __FILE__)
Dir[File.expand_path('../rabpub/', __FILE__)].each { |f| puts f; require f }
