class ShowsController < ApplicationController
  before_action :login_user_id
  def index
      @shows = Show.all.order('created_at DESC').paginate(:page => params[:page], :per_page => 3)
      bs = CreateClusterJob.new.perform('sidekiq-batch')
      # # bs = Sidekiq::Batch.new
      # puts bs
#       bds = Sidekiq::DeadSet.new
#       p "-----"
# bds.each do |status|
#   p status
#   status.dead_jids 
#   status.delete 
# end

      @favourites = Favourite.where(user_id:  @user.id)
  end

  def search 
      @search = params[:string]
      @shows = Show.joins(:channel).order('created_at DESC').select("shows.*").where("lower(shows.name) LIKE ? OR lower(channels.name) LIKE ?", "%#{@search.downcase}%", "%#{@search.downcase}%").paginate(:page => params[:page], :per_page => 3)
      @favourites = Favourite.where(user_id:  @user.id)
      render "index"
  end

  def favourites
    @favourites = @user.favorited_by_type 'Show'
  end

  def add_favourite
    @show = Show.find(params[:id])
    if !@user.favorited?(@show)
      @user.favorite(@show)
      redirect_to root_path,notice:"#{@show.name} is added to favourites"
    else
      redirect_to root_path,notice:"#{@show.name} is already in favourites"
    end
  end

  def remove_favourites
     @show = Show.find(params[:id])
     @user.unfavorite(@show)
     redirect_back fallback_location: root_path,notice:"#{@show.name} is removed from favourites"
  end


  private
  def login_user_id
    @user = current_user
  end
end
