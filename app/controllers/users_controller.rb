class UsersController < ApplicationController

  def show
   @user = User.find(params[:id])
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
      # @user = User.all                              #追加
      flash.now[:alert] = "会員登録に失敗しました。"  #追加
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
