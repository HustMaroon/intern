class LikesController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy]
	def create
		@micropost = Micropost.find(params[:micropost_id])
		@like = @micropost.likes.build(like_params)
		@like.user_id = current_user.id
		@like.save
		respond_to do |format|
         format.html { redirect_to @micropost }
         format.js
    end
	end

	def destroy
		like = Like.find(params[:id])
		@micropost = like.micropost 
		like.destroy
	    respond_to do |format|
         format.html { redirect_to @micropost }
         format.js
    end
	end

	private
	def like_params
		params.require(:like).permit(:micropost_id, :user_id)
	end
end
