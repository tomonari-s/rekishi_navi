class Post < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  def self.search_for(content, method)
    if method == 'perfect'
      Post.where(title: content)
    elsif method == 'forward'
      Post.where('title LIKE ?', content+'%')
    elsif method == 'backward'
      Post.where('title LIKE ?', '%'+content)
    else
      Post.where('title LIKE ?', '%'+content+'%')
    end
  end
  
  # def self.looks(search, word)
  #   if search == "perfect_match"
  #     @post = Post.where("title LIKE?","#{word}")
  #   elsif search == "forward_match"
  #     @post = Post.where("title LIKE?","#{word}%")
  #   elsif search == "backward_match"
  #     @post = Post.where("title LIKE?","%#{word}")
  #   elsif search == "partial_match"
  #     @post = Post.where("title LIKE?","%#{word}%")
  #   else
  #     @post = Post.all
  #   end
  # end
  
end