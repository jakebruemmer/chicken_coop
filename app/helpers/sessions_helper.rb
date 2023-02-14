module SessionsHelper
	def redirect_if_not_signed_in
		redirect_to root_path, notice: "You must be a user to make a Chicken" unless user_signed_in?
	end
end