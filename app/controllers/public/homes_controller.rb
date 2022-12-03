class Public::HomesController < ApplicationController
  
  def top
    @posts = Post.all.order(params[:sort])
  end  
  
  
  
  
end
