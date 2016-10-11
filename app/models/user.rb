class User < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!
	validates :email, uniqueness: true, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: "format not valid"}
	validates :password, presence: true, format: { with: /.{5}/, message: "minimum length of 5"}

	has_secure_password
	has_many :questions
	has_many :answers

end
