#Index all questions
get '/all_questions' do
	@all_questions = Question.all
	erb :"questions/index.html"
end

#Show users question
get '/my_questions' do
	@my_questions = current_user.questions
	erb :"questions/show.html"
end

#Pull HTML for a new question
get '/questions/new' do
	@questions = Question.all
	@user = User.find_by(id: session[:user_id])
	erb :"questions/new.html"
end




post '/questions' do 
	@question = current_user.questions.new(full_question: params[:description])
	if @question.save
		redirect '/read'
	else
		@flash_msg = @user.errors.full_messages
		redirect to '/questions/new'
	end
end

get '/questions/:id/edit' do
	@edit_question = Question.find(params[:id])
	erb :"questions/edit.html"
end

put '/questions/:id' do
	@edited_question = Question.find(params[:id])
	@edited_question.update(full_question: params[:updated_question])
	@my_questions = current_user.questions
	erb :"questions/index.html"
end

post '/questions/:id' do
	@deleted_question = Question.find(params[:id])
	@deleted_question.destroy
	@my_questions = current_user.questions
	erb :"questions/index.html"
end
