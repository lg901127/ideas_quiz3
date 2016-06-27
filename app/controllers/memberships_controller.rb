class MembershipsController < ApplicationController
  def create
    @idea = Idea.find params[:idea_id]
    if @idea.user != current_user
      membership = Membership.new(idea: @idea, user: current_user)
      if membership.save
        redirect_to idea_path(@idea), notice: "Joined!"
      else
        redirect_to idea_path(@idea), notice: "Error!"
      end
    else
      redirect_to idea_path(@idea), notice: "You can't join your own idea!"
    end
  end

  def destroy
    @idea = Idea.find params[:idea_id]
    @membership = Membership.find params[:id]
    @membership.destroy
    redirect_to idea_path(@idea), notice: "Left!"
  end

end
