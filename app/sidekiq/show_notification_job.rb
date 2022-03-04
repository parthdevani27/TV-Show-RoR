class ShowNotificationJob
  include Sidekiq::Job
  def perform(*args)
      @shows = Show.where(startTime: 30.minutes.from_now.beginning_of_minute)
      @shows.each do |show|
        favourites = show.favourites
        favourites.each do |item|
        ShowMailer.fav_show_email(item.user,show).deliver
        end
    end
  end
end
