class Admin::PostsController < ApplicationController
  def index
     @posts = Post.page(params[:page]).order(params[:sort])
     @comment = Comment.new
  end
  
  def show
     @post = Post.find(params[:id])
     @comment = Comment.new
  end
end
