#Go to particular answer page
get '/questions/:id/answers/new' do
	@current_question = Question.find(params[:id])
	erb :"answers/new.html"
end

#Create Answer
post '/questions/:question_id/answers' do
	@answer = current_user.answers.new(full_answer: params[:answer_question], question_id: params[:question_id])

	if @answer.save
		redirect '/'
	else
		@flash_msg = "error"
		erb :"answers/index.html"
	end
end

#Edit answers
get '/questions/:question_id/answers/:answer_id/edit' do
	@edit_question = Question.find(params[:question_id])
	@edit_answer = Answer.find(params[:answer_id])
	erb :"answers/edit.html"
end

#Update answers
put '/questions/:question_id/answers/:answer_id' do
	@answer = Answer.find(params[:answer_id])
	@answer.update(full_answer: params[:updated_answer])
	@questions = Question.all
		erb :"static/index.html"
end

#Delete Answers
post '/questions/:question_id/answers/:answer_id' do
	@answer = Answer.find(params[:answer_id])
	@answer.destroy
	@questions = Question.all
		erb :"static/index.html"
end

#Show my answers
get '/my_answers' do
	@my_answers = Answer.where(user_id: current_user.id)
	erb :"answers/index.html"
end


