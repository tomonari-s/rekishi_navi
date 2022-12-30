class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  def index
     @posts = Post.page(params[:page]).order(params[:sort])
     @comment = Comment.new
  end
  
  def show
     @post = Post.find(params[:id])
     @comment = Comment.new
  end
end
