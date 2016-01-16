class SharesController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy]
	before_action :correct_user, only: :destroy
 def create
  	micropost = Micropost.find_by(id: params[:id])
    @share = current_user.shares.build(share_params)
    if @share.save
      flash[:success] = "Post shared!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
  	@share.destroy
  	redirect_to request.referrer || root_url
  end

  def correct_user
	@share = current_user.shares.find_by(id: params[:id])
	redirect_to root_url if @share.nil?
  end

  def share_params
  	params.require(:share).permit(:content,:micropost_id)
  end
end
