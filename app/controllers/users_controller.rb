get '/' do
	if session[:user_id] != nil
		redirect to '/read'
	else
  	redirect to '/login'
  end
end

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

#Sign Up
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

get '/logout' do
	user = User.find_by(id: session[:user_id])
	session[:user_id] = nil
	user.logged_in = false
	redirect to '/login'
end

get '/login' do
	erb :"users/new.html"
end

#Listing Page
get '/read' do
	@questions = Question.all
	@answers = Answer.all
	@answer_votes = AnswerVote.all
	#@user = User.find_by(id: session[:user_id])
	erb :"static/index.html"
end

get '/users/show' do
	@questions = current_user.questions
	@answers = current_user.answers
	@user = User.find_by(id: session[:user_id])
	erb :"/users/show.html"
end


