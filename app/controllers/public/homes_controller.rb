class Public::HomesController < ApplicationController
  before_action :authenticate_user!, except: [:top]
  
  def top
    @posts = Post.page(params[:page]).order(params[:sort])
   
  end  
  
  
  
  
end
