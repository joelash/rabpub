class RabPubApplication < Sinatra::Base
  enable :sessions
  register Sinatra::Flash
  register SinatraMore::MarkupPlugin
  register SinatraMore::RenderPlugin

  root_dir = File.dirname(__FILE__) + '/../..'
  set :views, root_dir + '/views'
  set :public_folder, root_dir + '/public'

  get '/' do
    redirect to '/publish'
  end

  get '/publish' do
    haml_template 'publish'
  end

  post '/publish' do
    message = params[:rabbit_message]
    BunnyRabbit.publish message
    flash[:notice] = 'Successfully published message'
    redirect to '/publish'
  end

  get '/stylesheets/:css_file.css' do |css_file|
    file_name = "../public/stylesheets/#{css_file}"
    scss file_name.to_sym
  end
end
