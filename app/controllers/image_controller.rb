class ImageController < ApplicationController
  def index
    @images = Image.all
  end

  def destroy
    image = current_user.images.find(params[:id])
    image.destroy
    redirect_to :controller => :album, 
      :action => :show,
      :secret => params[:album_secret]
  end
end
