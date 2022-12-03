class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to root_path
  end
  
  def show
     @post = Post.find(params[:id])
     @comment = Comment.new
  end
  
  def update
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "投稿内容を更新しました."
    else
      render "edit"
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  
  private

  def post_params
    params.require(:post).permit(:title, :image, :text, :address, :lat, :lng, tag_ids: [])
  end
  
end
