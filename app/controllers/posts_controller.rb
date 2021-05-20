class PostsController < ApplicationController
	def index
		@posts = Post.joins(:user).order('id DESC')
	end

	def show
		@post = Post.find(params[:id])
	end
end
