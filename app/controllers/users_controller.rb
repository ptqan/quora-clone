#Static Index Page
get '/' do
	if session[:user_id] != nil
		redirect to '/read'
	else
  	redirect to '/login'
  end
end

#Login Page (Returns HTML for creating new account)
get '/login' do
	erb :"users/new.html"
end

#Top Stories Page (questions/index)
get '/read' do
	@questions = Question.paginate(:page => params[:page], :per_page => 5)
	@answers = Answer.all
	@answer_votes = AnswerVote.all
	#@posts = Post.paginate(:page => params[:page])
	#@user = User.find_by(id: session[:user_id])
	erb :"static/index.html"
end

#Login Normal
post '/login' do
	user = User.find_by(email: params[:email])
	if user.try(:authenticate, params[:password])
		session[:user_id] = user.id
		user.logged_in = true
		redirect to '/read'
	else
		@flash_msg = "User does not exist"
    erb :"users/new.html"
	end
end

#Login Ajax
post '/login/ajax' do
	user = User.find_by(email: params[:email])
	if user.try(:authenticate, params[:password])
		session[:user_id] = user.id
		#user.logged_in = true
		return user.to_json
	else
		@flash_msg = {errors: "User does not exist"}
		return @flash_msg.to_json
	end
end

#Sign Up Normal
post '/users' do
  @user = User.new(full_name: params[:full_name],email: params[:email], password: params[:password])
   if @user.save 
       session[:user_id] = @user.id
       redirect '/read'
   else
       @flash_msg = @user.errors.full_messages;
       erb :"users/new.html"
   end
end

#Sign Up Ajax
post '/users/ajax' do
	@user = User.new(full_name: params[:full_name],email: params[:email], password: params[:password])
   if @user.save
   		 session[:user_id] = @user.id 
       return @user.to_json
   else
       @flash_msg = {errors: "#{@user.errors.full_messages.join(",")}"}
			return @flash_msg.to_json
   end
end

#Logout Page
get '/logout' do
	user = User.find_by(id: session[:user_id])
	session[:user_id] = nil
	user.logged_in = false
	redirect to '/login'
end





# get '/users/show' do
# 	@questions = current_user.questions
# 	@answers = current_user.answers
# 	@user = User.find_by(id: session[:user_id])
# 	erb :"/users/show.html"
# end


