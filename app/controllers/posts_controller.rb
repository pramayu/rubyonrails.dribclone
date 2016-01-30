class PostsController < ApplicationController
	before_action :find_post, only: [:show, :edit, :update, :destroy, :upvote, :log_impression, :maxshow]
	before_action :authenticate_user!, except: [:index, :show, :register_info, :maxshow]
	before_filter :log_impression, only: [:show]

	layout false, only: [:maxshow]

	def index
		if params[:tag]
			@posts = Post.tagged_with(params[:tag]).paginate(:page => params[:page], :per_page => 20)
		else
			@posts = Post.all.order("created_at desc").paginate(:page => params[:page], :per_page => 20)
		end
		@uposts = Post.all.order("user_id desc").limit(4)
	end

	def show
		@comments = Comment.where(post_id: @post)
		@random_posts = Post.all.where(user_id: @post.user.id).where.not(id: @post.id).order("created_at").limit(4)
	end

	def new
		#@post = Post.new
		@post = current_user.posts.build
	end
	## save file to databases
	def create
		@post = current_user.posts.build(post_params)
		if @post.save
			redirect_to @post
		else
			render 'new'
		end
	end

	def edit
		
	end
	## update a file
	def update
		if @post.update(post_params)
			redirect_to @post
		else
			render 'edit'
		end
	end

	def destroy
		@post.destroy
		redirect_to root_path
	end

	def upvote
		@post.upvote_by current_user
		redirect_to :back
	end

	def log_impression
		if user_signed_in?
			@post.impressions.create(ip_address: request.remote_ip, user_id:current_user.id)
		else
			@post.impressions.create(ip_address: request.remote_ip)
		end
	end

	def register_info
		
	end

	def maxshow
		respond_to do |format|
			format.html
			format.js
		end
	end

	private

	def post_params
		params.require(:post).permit(:title, :link, :description, :image, :attach, :tag_list)
	end

	def find_post
		@post = Post.find(params[:id])
	end
end