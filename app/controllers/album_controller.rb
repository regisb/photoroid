class AlbumController < ApplicationController
  def index
    @user = current_user
  end

  def show
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
    @album = Album.find_by_secret(params[:album][:secret])
    if @album && params[:album][:images]
      params[:album][:images].each{|param|
        image = @album.images.build
        image.img = param
        image.save
      }
      redirect_to :controller => :album, :action => :index, :secret => @album.secret
      return
    end
    redirect_to :controller => :user, :action => :index
  end

  def download
    # Make request post
    @album = Album.find_by_secret(params[:secret])
    file_path = nil
    tmp_file = nil
    if @album 
      images = @album.images
      if !images.blank?
        file_path = Album.create_archive_path
        # Create zip file
        Zip::ZipFile.open(file_path, Zip::ZipFile::CREATE){|z|
          # Add root directory to zipfile
          z.mkdir(@album.title)
          # Fill with images
          images.each{|image|
            # Add image inside of root directory
            z.add(File.join(@album.title, image.img_file_name), 
                  image.img.path)
          }
        }
      end
    end
    file_name = @album.title + ".zip"
    send_file file_path, :type => 'application/zip',
      :disposition => 'attachment',
      :filename => file_name 
    File.delete(file_path)
  end
end
