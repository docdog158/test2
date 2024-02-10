class Favorite < ApplicationRecord
  
  belongs_to :user
  belongs_to :book
  
  #通知機能
  has_one :notification, as: :notifiable, dependent: :destroy
  
  after_create do
    create_notification(user_id: book.user_id)
  end
  
  validates :user_id, uniqueness: {scope: :book_id}
  
end
