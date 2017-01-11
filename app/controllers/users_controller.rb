class UsersController < ApplicationController
  before_action :logged_in_user, only:[:edit, :update]

  def show
   @user = User.find(params[:id])
   @microposts = @user.microposts.order(created_at: :desc).page(params[:page]).per(10)
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
       flash[:success] = "会員登録に成功しました。"
       redirect_to @user
    else
      #Signupに失敗した場合
      flash.now[:alert] = "会員登録に失敗しました。"  #追加
      render 'new'
    end
  end

  def edit
   user_check
  end
  
  def update
    user_check   
    if @user.update(user_params)
      # 保存に成功したらProfileへリダイレクト
      redirect_to @user
    else
      flash.now[:alert] = "更新できませんでした"
      render 'edit'
    end  
  end
  
  
  def followings
    @user = User.find(params[:id])
    @following = @user.following_users
    @following_page = @following.page(params[:page]).per(10)
  end
  
  def followers
    @user = User.find(params[:id])
    @follower = @user.follower_users
    @follower_page = @follower.page(params[:page]).per(10)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation,
                                 :profile)
  end
  
  def user_check
    @user = User.find(params[:id])
    if (current_user != @user)
       redirect_to root_path
    end
  end
  
end
