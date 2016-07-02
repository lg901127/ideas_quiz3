class LikesMailer < ApplicationMailer
  def like_notify(idea)
    @idea = idea
    @user = @idea.user
    mail(to @user.email, subject: "Your idea is liked!")
  end
end
