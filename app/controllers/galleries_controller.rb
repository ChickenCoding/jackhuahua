class GalleriesController < ApplicationController
  def index
  	@galleries = Gallery.all
    authorize @galleries
  end

  def show
    @user = User.find(params[:user_id])
  	@gallery = Gallery.find(params[:id])

    @favorite = @gallery.favorites.where(user_id: current_user.id).first if current_user
    @new_favorite = Favorite.new
    authorize @gallery

    add_breadcrumb "Back to #{@user.name}'s page", user_path(@user)
  end

  def new
    @user = User.find(params[:user_id])
  	@gallery = Gallery.new
    authorize @gallery
  end

  def create
     @user = User.find(params[:user_id])
     @gallery = current_user.galleries.build(gallery_params)
     authorize @gallery

     if @gallery.save
       flash[:notice] = "Gallery was saved."
       redirect_to [@user, @gallery]
     else
       flash[:error] = "There was an error saving the gallery. Please try again."
       render :new
     end
  end

  def edit
    @dog = Dog.find(params[:dog_id])
  	@gallery = Gallery.find(params[:id])
    authorize @gallery
  end

  def update
     @user = User.find(params[:user_id])
     @gallery = Gallery.find(params[:id])
     authorize @gallery
     
     if @gallery.update_attributes(gallery_params)
       flash[:notice] = "Gallery was updated."
       redirect_to [@user, @gallery]
     else
       flash[:error] = "There was an error saving the gallery. Please try again."
       render :edit
     end
  end

   def destroy
     @user = User.find(params[:user_id])
     @gallery = Gallery.find(params[:id])
     authorize @gallery
 
     if @gallery.destroy
       flash[:notice] = "\"#{@gallery.title}\" was deleted successfully."
       redirect_to @user
     else
       flash[:error] = "There was an error deleting the gallery."
       render :show
     end
   end

  private

  def gallery_params
    params.require(:gallery).permit(:title, :body, :user_id, :image, :filepicker_url)
  end
end
