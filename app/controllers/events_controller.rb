class EventsController < ApplicationController
	def index
		@events = Event.all
		@user = User.find(current_user)
	end

	def create
		@event = Event.new(event_params)
		if @event.save
			redirect_to :back
		else
			flash[:errors] = @event.errors.full_messages
			redirect_to :back
		end
	end

	def show
		@event = Event.find(params[:id])
		@users = User.all
		@comments = Comment.all.where(event_id: @event.id)
	end

	def update
		@event = Event.find(params[:id])
		@event.users << current_user
		redirect_to :back
	end

	def destroy
		@event = Event.find(params[:id])
		@event.destroy
		redirect_to :back
	end

	def edit
		@event = Event.find(params[:id])
	end

	def edit_event
		@event = Event.find(params[:id])
		if @event.update(name: params[:name], date: params[:date], city: params[:city], state: params[:state])
			return redirect_to events_path
		else
			flash[:errors] = @event.errors.full_messages
			redirect_to :back
		end
	end

	def unjoin
		@user = User.find(current_user.id)
		@event = Event.find(params[:id])
		@event.users.delete(@user)
		redirect_to :back
	end

  private
    def event_params
      params.require(:event_form).permit(:name, :date, :city, :state).merge(user_id: current_user.id)
    end

end
