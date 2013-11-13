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
  Pony.mail :to => 'john@doe.com',
            :from => 'user@mail.com',
            :subject => "Thanks for request, #{params[:name]}!",
            :body => haml(:email, :layout => false),
            :via => :smtp,
            :via_options => {
              :address => 'smtp.gmail.com',
              :port => '587',
              :enable_starttls_auto => true,
              :user_name => 'user@mail.com',
              :password => 'pass',
              :authentication => :plain
            }

  message = "#{params} - send successfully!"
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