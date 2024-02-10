class Book < ApplicationRecord
  
  belongs_to :user
  has_many :favorites, dependent: :destroy
  
  #通知機能
  has_many :notifications, as: :notifiable, dependent: :destroy


  has_many :book_comments, dependent: :destroy
  

  #通知機能
  after_create do
    user.followers.each do |follower|
      notifications.create(user_id: follower.id)
    end
  end  
  #end
  
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  
  #検索機能
  def self.search_for(content, method)
    if method == 'perfect'
      Book.where(title: content)
    elsif method == 'forward'
      Book.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      Book.where('name LIKE ?', '%' + content)
    else
      Book.where('name LIKE ?', '%' + content + '%')
    end
  end
  
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
