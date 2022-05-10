class UsersController < ApplicationController
  # GET /users/:id
  def show
    @user = User.find(params[:id])
  end
  
  # GET /users/new
  def new
    @user = User.new
  end
  
  #POST/users (+ params)
  def create
    @user = User.new(user_params)
      # 実装は終わっていないことに注意!
    #(user + given params).save
    if @user.save
      # 保存の成功をここで扱う。
      
      flash[:success] = "Welcome to the Sample App!"
      
      #GET "/users/#{@user.id}"
      redirect_to @user
      # redirect_to user_path(@user)
      # redirect_to user_path(@user.id)
      # redirect_to user_path(1)
      #             => /users/1
      
    else
      render 'new'
    end
  end
  
  private
  
  def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
  end
  
end
