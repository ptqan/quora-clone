get '/users' do

	@user = User.all
  erb :"static/index"
end

get '/homepage' do
	@current_user = current_user
	erb :"static/read"
end

post '/users' do
  @user = User.new(full_name: params[:full_name],email: params[:email], password: params[:password])

 	if @user.save 
 		session[:user_id] = @user.id
 		redirect '/homepage'
 	else
 		@flash_msg = @user.errors.full_messages;
 		erb :"static/index"
 	end
end

get '/users/:id' do

  erb :"users/show"
end

post '/login' do
	user = User.find_by(email: params[:email])

	if user.try(:authenticate, params[:password])
		session[:user_id] = user.id
		redirect '/homepage'
	else
		@login_msg = "User does not exist";
		erb :"static/index"
	end
end

post '/logout' do
	session[:user_id] = nil
	redirect '/'
end