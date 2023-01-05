class Public::HomesController < ApplicationController
  before_action :authenticate_user!, except: [:top]
  
  def top
    @posts = Post.page(params[:page]).order(params[:sort])
      # if order(params[:sort_favorite])
      #     @posts = Post.page(params[:page]).find(Favorite.group(:post_id).order('count(post_id) desc').pluck(:post_id))
      # end
  end  
  
  
  
  
end
