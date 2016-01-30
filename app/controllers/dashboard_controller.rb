class DashboardController < ApplicationController 
	before_action :authenticate_user!, except: [:show]

	def show
		@user = User.find_by_id(params[:id])
		@posts = @user.posts.order("title asc").paginate(:page => params[:page], :per_page => 50)
	end
end