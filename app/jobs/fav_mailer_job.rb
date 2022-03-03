class FavMailerJob < ApplicationJob
  queue_as :default

  def perform(*args)
    User.find_each do |user|
      # CatfactMailer.with(user: user, fact: CatfactServices::Catfact.new.daily_fact).daily_catfact.deliver_now
      @favourite = Favourite.find(33)
      ShowMailer.fav_show_email(@user,@favourite.show).deliver
    end
  end
end
