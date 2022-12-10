class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  # has_one_attached :image       
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  # def get_profile_image
  #   (profile_image.attached?) ? profile_image : 'no_image.jpg'
  # end
         
  # is_deletedがfalseならtrueを返すようにしている
  def active_for_authentication?
    super && (is_deleted == false)
  end         
  
  # ゲストログイン２
  # def guest_sign_in
  def self.guest  
    user = User.find_or_create_by!(last_name: 'さんぷる' , first_name: 'さんぷる2' , last_name_kana: 'サンプル' , first_name_kana: 'サンプル2',email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      # user.skip_confirmation!  # Confirmable を使用している場合は必要
      # 例えば name を入力必須としているならば， user.name = "ゲスト" なども必要
    end
  end
  # # ゲストログイン１
  # def self.guest
  #   find_or_create_by!(email: "guest@example.com") do |user|
  #     user.password = SecureRandom.urlsafe_base64
  #     user.confirmed_at = Time.now # ← Confirmable を設定している場合は追加
  #     # user.name = "ゲストユーザー" # ←ユーザー名を設定している場合は追加
  #   end
  # end  
  
  
  def self.search_for(content, method)
    if method == 'perfect'
      User.where('(last_name + first_name) LIKE ?', content)
      # User.where(last_name: content)
      # User.where(last_name: content)
    elsif method == 'forward'
      User.where('last_name LIKE ? OR last_name_kana LIKE ?', content + '%', content + '%')
    elsif method == 'backward'
      User.where('first_name LIKE ? OR first_name_kana LIKE ?', '%' + content, '%' + content)
    else
      User.where('last_name LIKE ? OR first_name LIKE ? OR last_name_kana LIKE ? OR first_name_kana LIKE ?', '%' + content + '%', '%' + content + '%', '%' + content + '%', '%' + content + '%')
    end
  end
  # def self.looks(search, word)
  #   if search == "perfect_match"
  #     @user = User.where("last_name LIKE?", "#{word}")
  #   elsif search == "forward_match"
  #     @user = User.where("name LIKE?","#{word}%")
  #   elsif search == "backward_match"
  #     @user = User.where("name LIKE?","%#{word}")
  #   elsif search == "partial_match"
  #     @user = User.where("name LIKE?","%#{word}%")
  #   else
  #     @user = User.all
  #   end
  # end
  
end
