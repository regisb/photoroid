class AlbumsController < ApplicationController
  def index
    @user = current_user
  end

  def show
    @album = Album.find_by_secret(params[:secret])
    if @album.nil?
      render :partial => "invalid" and return
    end
  end

  def new
    if current_user.nil?
      redirect_to :controller => :user, :action => :show and return
    else
      @album = Album.new
    end
  end

  def edit
    @album = current_user.albums.find(params[:id])
  end

  def update
    @album = current_user.albums.find(params[:id])
    if @album.update_attributes(params[:album])
      redirect_to :controller => :albums, :action => :show, :secret => @album.secret and return
    else
      render :controller => :albums, :action => :new
    end
  end

  def create
    @album = current_user.albums.build(params[:album])
    if @album.save
      redirect_to :controller => :albums, :action => :show, :secret => @album.secret and return
    else
      render :controller => :albums, :action => :new
    end
  end

  def upload_images
    @album = Album.find_by_secret(params[:album][:secret])
    if @album && params[:album][:images]
      params[:album][:images].each{|param|
        image = @album.images.build(:author_name => params[:author_name])
        image.img = param
        image.save
      }
    end
    redirect_to :controller => :albums, :action => :show, :secret => @album.secret
  end

  def destroy
    current_user.albums.find(params[:id]).destroy unless current_user.blank?
    redirect_to :controller => :albums, :action => :index
  end

  def download

    @album = Album.find_by_secret(params[:secret])
    file_path = nil
    tmp_file = nil
    images = @album.images
    files = {} # Dictionary of image path/image id added to the zip file
    folders = Set.new

    if !images.blank?

      file_path = Album.create_archive_path
      
      # Create zip file
      Zip::ZipFile.open(file_path, Zip::ZipFile::CREATE){|z|

        # Add root directory to zipfile
        z.mkdir(@album.title)

        # Fill with images
        images.each{|image|
          # Calculate image path in zip file
          folder = File.join(@album.title, image.author_name).capitalize
          base = File.basename(image.img_file_name, ".*").capitalize
          ext = File.extname(image.img_file_name).downcase
          path = File.join(folder, base + ext)
          index = 0
          while files.has_key?(path)
            path = File.join(folder, base + "-#{index}" + ext)
            index += 1
          end
          files[path] = image.id

          # Create folder if necessary
          z.mkdir(folder) if folders.add?(folder)

          # Add image inside of root directory
          z.add(path, image.img.path)
        }
      }
    end
    file_name = @album.title + ".zip"
    send_file file_path, :type => 'application/zip',
      :disposition => 'attachment',
      :filename => file_name 
    File.delete(file_path)
  end
end
