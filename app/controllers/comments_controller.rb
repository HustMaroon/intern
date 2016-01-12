class CommentsController < ApplicationController
before_action :logged_in_user, only: [:create]
	def create
		micropost = Micropost.find(params[:micropost_id])
		@comment = micropost.comments.build(comment_params)
		@comment.user_id = current_user.id
		if @comment.save
			redirect_to micropost
		else
			redirect_to micropost
		end
	end

	def destroy
		@comment = Comment.find_by(params[:id])
		micropost = @comment.micropost
		@comment.destroy
		redirect_to micropost

	end

	private
	def comment_params
		params.require(:comment).permit(:content, :micropost_id, :picture)
	end
end
