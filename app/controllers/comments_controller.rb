class CommentsController < ApplicationController
  def new
  	@event = Event.find(params[:event_id])
  	@comment = Comment.new(content: params[:content], event_id: @event.id, user_id: current_user.id)
  	if @comment.save
  		redirect_to :back
  	else
  		flash[:errors] = @comment.errors.full_messages
  		redirect_to :back
  	end
  end
end
