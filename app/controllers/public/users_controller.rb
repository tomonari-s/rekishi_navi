class Public::UsersController < ApplicationController
  
  def show
    # @user = current_user
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page])
    # @posts = Post.page(params[:page]).order(params[:sort])
    favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update(user_params)
    redirect_to users_my_page_user_path(@user.id)
  end

  def unsubscribe
    @user = current_user
  end

  def withdrawal
    @user = current_user
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end
  
  
  
  private
  def user_params
    params.require(:user).permit(:user_id, :last_name, :first_name, :last_name_kana, :first_name_kana, :email)  
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
end
