class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  
  # Add your routes here
  get "/" do
    { message: "This is the root route" }.to_json
  end

  #  we want these core three routes to work 
  # login/signup spit back a token 
  post "/signup" do
    {message:"signup route "}.to_json
  end
  post "/login" do
    {message:"login route "}.to_json
  end
  # this is the only route for now that uses a token 
  get "/profile" do
    {message:"profile route "}.to_json
  end
end
