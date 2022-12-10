class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
        
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  
         
  # is_deletedがfalseならtrueを返すようにしている
  def active_for_authentication?
    super && (is_deleted == false)
  end         
  
  # ゲストログイン
  
  def self.guest  
    user = User.find_or_create_by!(last_name: '動作' , first_name: '確認' , last_name_kana: 'ドウサ' , first_name_kana: 'カクニン',email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end
   
  
  
  def self.search_for(content, method)
    if method == 'perfect'
      User.where('(last_name + first_name) LIKE ?', content)
    elsif method == 'forward'
      User.where('last_name LIKE ? OR last_name_kana LIKE ?', content + '%', content + '%')
    elsif method == 'backward'
      User.where('first_name LIKE ? OR first_name_kana LIKE ?', '%' + content, '%' + content)
    else
      User.where('last_name LIKE ? OR first_name LIKE ? OR last_name_kana LIKE ? OR first_name_kana LIKE ?', '%' + content + '%', '%' + content + '%', '%' + content + '%', '%' + content + '%')
    end
  end
  
end
