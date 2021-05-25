class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy, :filter_provider]
  load_and_authorize_resource
  layout 'admin'

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = current_user.users.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to admin_users_path, notice: 'user was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to admin_users_path, notice: 'user was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to admin_users_path, notice: 'user was successfully destroyed.' }
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
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:fullname)
    end
end

