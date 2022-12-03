class Public::HomesController < ApplicationController
  
  def top
    @posts = Post.page(params[:page]).order(params[:sort])
    
  end  
  
  
  
  
end
