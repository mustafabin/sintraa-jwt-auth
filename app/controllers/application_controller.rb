class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'

  def get_secret_key
    "123"
  end
  def generate_token(user_id)
    JWT.encode({user_id: user_id}, get_secret_key)
  end

  def decode_token(token)
    JWT.decode(token, get_secret_key)[0]["user_id"]
  end

  get "/" do
    { message: "This is the root route" }.to_json
  end
  
  post "/sign_up" do
    # user = User.create!(email:  )
    puts params[:email]
    hashed_password =  BCrypt::Password.create( params[:password])
    puts hashed_password ==  params[:password]
    user = User.create!(email: params[:email], password: hashed_password)
    token = generate_token(user.id)
    { token: token }.to_json
  end

  get "/profile" do
    user_id = decode_token(env["HTTP_TOKEN"])
    user = User.find(user_id)
    user.to_json
  end

  post "/login" do
    user = User.find_by!(email: params[:email])
    user_password = BCrypt::Password.new(user.password)
    if user_password == params[:password] 
      token = generate_token(user.id)
      { token: token }.to_json
    else
      { message: "incorrect password" }.to_json
    end
  end
end
