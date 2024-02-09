class Favorite < ApplicationRecord
  
  belongs_to :user
  belongs_to :book
  
  #通知機能
  has_one :notifications, as: :notifiable, dependent: :destroy
  
  validates :user_id, uniqueness: {scope: :book_id}
  
end
