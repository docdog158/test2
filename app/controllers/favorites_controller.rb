class FavoritesController < ApplicationController
  
  def create
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: @book.id)
    favorite.save
    #非同期通信
    #redirect_to request.referer
  end

  def destroy
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: @book.id)
    favorite.destroy
    #非同期通信
    #redirect_to request.referer
  end
  
  #通知機能
  after_create do
    create_notification(user_id: book.user_id)
  end


end
