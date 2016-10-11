post '/users/:user_id/answer/:answer_id/upvote' do
	@vote = AnswerVote.find_by(user_id: params[:user_id], answer_id: params[:answer_id])

		if @vote.present?
			return "User id already exist"
		else
			@vote = AnswerVote.new(user_id: params[:user_id],answer_id: params[:answer_id],vote_type: true)
			if @vote.save
				#ALL GOOD
				redirect to '/read'
			else
				@flash_msg = @user.errors.full_messages;
				return @flash_msg
				#redirect to '/read' # with error message
			end
		end
end

post '/users/:user_id/answer/:answer_id/downvote' do
	@vote = AnswerVote.find_by(user_id: params[:user_id], answer_id: params[:answer_id])

		if @vote.present?
			return "User id already exist"
		else
			@vote = AnswerVote.new(user_id: params[:user_id],answer_id: params[:answer_id],vote_type: false)
			if @vote.save
				#ALL GOOD
				redirect to '/read'
			else
				@flash_msg = @user.errors.full_messages;
				return @flash_msg
				#redirect to '/read' # with error message
			end
		end
end