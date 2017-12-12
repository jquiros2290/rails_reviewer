class SessionsController < ApplicationController
	def create
	user = User.find_by(email: params[:email])

	if user
		if user.try(:authenticate, params[:password])
			session[:user_id] = user.id
			return redirect_to events_path
		end
			flash[:errors] = ["Password is incorrect"]
		else
			flash[:errors] = ["Email is incorrect"]
		end

		return redirect_to :back
	end

	def destroy
		reset_session
		redirect_to users_path
	end
end
