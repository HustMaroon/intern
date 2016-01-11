class CommentsController < ApplicationController
before_action :logged_in_user, only: [:create]
	def create
		micropost = Micropost.find(params[:micropost_id])
		@comment = micropost.comments.build(comment_params)
		@comment.user_id = current_user.id
		if @comment.save
			redirect_to micropost
		else
			redirect_to root_url
		end
	end

	private
	def comment_params
		params.require(:comment).permit(:content, :micropost_id)
	end
end
