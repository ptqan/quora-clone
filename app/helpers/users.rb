helpers do
	#This will return the current user, if they exist
	#Replace with code that works with your application

	def current_user
		if session[:user_id]
			return @current_user ||= User.find(session[:user_id])
		end
	end

	def base_url 
		return "http://localhost:9393/"
	end
	
	#Returns true if current_user exists, false otherwise
	def logged_in?
		!current_user.nil?
	end

	def count_vote(type,answer_id)
		@current_answer = Answer.find(answer_id)

		if type == true
			@howmanytrue = @current_answer.answer_votes.where(vote_type: true).count
			return @howmanytrue
		else
			@howmanyfalse = @current_answer.answer_votes.where(vote_type: false).count
			return @howmanyfalse
		end

	end
end