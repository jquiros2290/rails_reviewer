class UsersController < ApplicationController
	def index
	end

	def create
		@user = User.create(form_params)
		if @user.valid?
			session[:user_id] = @user.id
			return redirect_to events_path
		end

		flash[:errors] = @user.errors.full_messages
		return redirect_to :back
	end

	def update
		@user = User.find(current_user.id)
		if @user.update(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], city: params[:city], state: params[:state])
			return redirect_to events_path
		else
			flash[:errors] = @user.errors.full_messages
			redirect_to :back
		end
	end


  private
    def form_params
      params.require(:user_form).permit(:first_name, :last_name, :email, :city, :state, :password)
    end
end
