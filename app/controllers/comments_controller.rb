class CommentsController < ApplicationController
before_action :logged_in_user, only: [:create]
	def create
		@cmicropost = Micropost.find(params[:micropost_id])
		@comment = @cmicropost.comments.build(comment_params)
		@comment.user_id = current_user.id
		if @comment.save
			respond_to do |format|
				format.html do
					redirect_to @cmicropost
				end
				format.js
			end
		end
	end

	def destroy
		@comment = Comment.find_by(params[:id])
		@cmicropost = @comment.micropost
		@delete_id = @comment.id
		@comment.destroy
		respond_to do |format|
			format.html do
				redirect_to @cmicropost
			end
			format.js
		end
	end

	private
	def comment_params
		params.require(:comment).permit(:content, :micropost_id, :picture)
	end
end
