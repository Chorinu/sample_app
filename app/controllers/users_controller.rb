class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  # 先にlogged_in_userをしないと、correct_userが呼び出せない
  before_action :admin_user,     only: :destroy
  
  def index
    @users = User.paginate(page: params[:page])
  end
  
  # GET /users/:id
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
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
      log_in @user
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
  
  #GET /users/:id/edit
  def edit
    @user = User.find(params[:id])
  end
  
  # PATCH /users/:id
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      # 更新に成功した場合を扱う。
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  # DELETE /users/:id
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end
  
  private
  
    def user_params
        params.require(:user).permit(:name, :email, :password,
                                     :password_confirmation)
    end
  
    # beforeアクション

    # application_controller.rb と重複するので削除
    # # ログイン済みユーザーかどうか確認
    # def logged_in_user
    #   unless logged_in?
    #     store_location
    #     flash[:danger] = "Please log in."
    #     redirect_to login_url
    #   end
    # end
    
  # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
      #redirect_to(root_url) unless @user == current_user
      #current_userメソッドを使うことでシンプルにできる
    end
    
  # 管理者かどうか確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
