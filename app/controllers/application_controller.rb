class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  
  # Add your routes here
  get "/" do
    { message: "This is the root route" }.to_json
  end
  
  post "/sign_up" do
    # user = User.create!(email:  )
    puts params[:email]
    hashed_password =  BCrypt::Password.create( params[:password])
    puts hashed_password ==  params[:password]
    user = User.create!(email: params[:email], password: hashed_password)
    user.to_json
  end

  get "/profile" do
    { message: "This is the profile route" }.to_json
  end

  post "/login" do
    user = User.find_by(email: params[:email])
    user_password = BCrypt::Password.new(user.password)
    puts params[:password]
    if user_password == params[:password] 
      { message: "correct" }.to_json
    else
      { message: "incorrect" }.to_json
    end
  end
end
