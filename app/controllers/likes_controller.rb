class LikesController < ApplicationController
  def create
    @idea = Idea.find params[:idea_id]
    if @idea.user != current_user
      like = Like.new(idea: @idea, user: current_user)
      if like.save
        redirect_to idea_path(@idea), notice: "Liked!"
      else
        redirect_to idea_path(@idea), notice: "Error!"
      end
    else
      redirect_to idea_path(@idea), notice: "You can't like your own idea!"
    end
  end

  def destroy
    @idea = Idea.find params[:idea_id]
    @like = Like.find params[:id]
    @like.destroy
    redirect_to idea_path(@idea), notice: "Unliked!"
  end

end
