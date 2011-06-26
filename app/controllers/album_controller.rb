class AlbumController < ApplicationController
  def index
    @album = Album.find_by_secret(params[:secret])
    if @album.nil?
      redirect_to :controller => :user, :action => :index
      return
    end
  end

  def new
    if current_user.nil?
      redirect_to :controller => :user, :action => :index
    else
      if request.post?
        # Create album
        @album = current_user.albums.build
        @album.title = params[:title]
        if @album.save
          redirect_to :controller => :album, :action => :index, :secret => @album.secret
          return
        end
      end
    end
  end

  def upload_images
    if request.post?
      if current_user.albums.present?
        @album = current_user.albums.find(params[:album][:id])
        if @album
          params[:images].each do |img_index, img_bin|
            image = @album.images.build
            # TODO write file correctly
            image.img = img_bin
            image.save
          end
          redirect_to :controller => :album, :action => :index, :secret => @album.secret
          return
        end
      end
    end
    redirect_to :controller => :album, :action => :index
  end

end
