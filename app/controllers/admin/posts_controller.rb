class Admin::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy, :filter_provider]
  layout 'admin'

  def index
    @posts = current_user.list_posts
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = current_user.posts.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to admin_posts_path, notice: 'post was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to admin_posts_path, notice: 'post was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to admin_posts_path, notice: 'post was successfully destroyed.' }
    end
  end

  def filter_provider
    supplier_exist =  Supplier.joins(:products).where("products.branch_id = ? ", params[:id]).group(:id).pluck(:id)
    if supplier_exist.blank?
      @supplier_list = Supplier.all
      @status = true
    else
      @supplier_list = Supplier.where.not(:id => supplier_exist)
      @status = false
    end

    respond_to do |format|
      format.js
    end
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:name, :user_id, :title, :content)
    end
end
