require 'rubygems'
require 'sinatra'
require 'haml'
require 'pony'

set :haml, { :format => :html5, :attr_wrapper => '"' }

get '/' do
  @message = 'hello world'
  haml :index
end

post '/' do
  # Pony.mail :to => 'my.mail@mail.com',
  #           :from => 'from.mail@mail.com',
  #           :subject => "Thanks for request, #{params[:name]}!",
  #           :body => erb(:email),
  #           :via => :smtp,
  #           :via_options => {
  #             :address => 'smtp.gmail.com',
  #             :port => '587',
  #             :enable_starttls_auto => true,
  #             :user_name => 'user@mail.com',
  #             :password => 'clearpass',
  #             :authentication => :plain
  #           }

  message = "#{params}"
end

not_found do
  @err = '404'
  @message = 'wrong page'
  @hint = 'check page url'
  erb :error
end

error do
  @err = '500'
  @message = 'something went wrong...'
  @hint = 'try again'
  erb :error
end