class ShowMailer < ApplicationMailer
  def fav_show_email(user,show)
    @user = user
    @show = show
    mail(to: @user.email, subject: "Your fav show #{@show.name} will start in 30 min ")
  end
end
