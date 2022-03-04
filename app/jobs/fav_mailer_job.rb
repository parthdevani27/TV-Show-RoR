class FavMailerJob < ApplicationJob
  include Sidekiq::Job
  def perform()
    # @shows = Show.where(startTime: 2.minutes.from_now.beginning_of_minute)
    # @shows.each do |show|
        # users = show.favoritors
        # users.each do |user|
        puts "Hard Job perform method is here with name"
        @user = User.find(1)
        @show = Show.find(19)
          ShowMailer.fav_show_email(@user,@show).deliver
        # end
    # end
  end
end
