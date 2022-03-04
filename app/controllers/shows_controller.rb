class ShowsController < ApplicationController
  before_action :login_user_id
  def index
      @shows = Show.all.paginate(:page => params[:page], :per_page => 3).order("created_at DESC")
      @favourites = Favourite.where(user_id:  @user.id)
  end

  def search 
      @search = params[:string]
      @shows = Show.where("lower(name) LIKE ? OR lower(description) LIKE ?", "%#{@search.downcase}%", "%#{@search.downcase}%").paginate(:page => params[:page], :per_page => 3)
      @favourites = Favourite.where(user_id:  @user.id)
      render "index"
  end

  def favourites
    @favourites = Favourite.where(user_id:  @user.id).order("created_at DESC")
  end

  def add_favourite
    # @show = Show.find(params[:id])
    # if @show.favorited_by?(@user)
    #   @user.favorite(@show)
    #   redirect_to root_path,notice:"#{@show.name} is added to favourites"
    # else
    #   redirect_to root_path,notice:"#{@show.name} is already in favourites"
    # end

    @oldFavourite = Favourite.where(show_id: params[:id],user_id:  @user.id).first
    if @oldFavourite 
      redirect_to root_path,notice:"#{@oldFavourite.show.name} is already in favourites"
    else
      @favourite = Favourite.new(show_id: params[:id],user_id:  @user.id)
      @favourite.save
      redirect_to root_path,notice:"#{@favourite.show.name} is added to favourites"
    end
  end

  def remove_favourites
     @favourite = Favourite.find(params[:id])
     @favourite.destroy
     redirect_back fallback_location: root_path,notice:"#{@favourite.show.name} is removed from favourites"
  end


  private
  def login_user_id
    @user = current_user
  end
end
