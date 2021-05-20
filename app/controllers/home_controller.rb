class HomeController < ApplicationController
  def index
  	@posts = Post.joins(:user).order("id DESC")
  end
end
