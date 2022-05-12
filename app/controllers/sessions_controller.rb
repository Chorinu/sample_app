class SessionsController < ApplicationController
  
  # GET /login
  def new
    # x @session = Session.new
    # o scope: :session + url: login_path
  end
  
  # POST/login
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # ユーザーログイン後にユーザー情報のページにリダイレクトする
      log_in user
      redirect_to user
    else
      # エラーメッセージを作成する
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
      # redirect_to vs. render
      # GET /users/1 => show template
      #                 render 'new'(0回)
    end
  end
  
  def destroy
    log_out
    redirect_to root_url
  end
  
end