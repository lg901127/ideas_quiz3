class IdeasController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  def new
    @idea = Idea.new
  end

  def index
    @ideas = Idea.order("created_at")
  end

  def create
    # render json: params
    byebug
    idea_params = params.require(:idea).permit(:title, :body, :avatar)
    @idea = Idea.new idea_params
    @idea.user = current_user
    if @idea.save
      redirect_to idea_path(@idea), notice: "Idea created!"
    else
      render :new
    end
  end

  def edit
    @idea = Idea.find params[:id]
  end

  def update
    @idea = Idea.find params[:id]
    idea_params = params.require(:idea).permit(:title, :body)
    if @idea.update idea_params
      redirect_to idea_path(@idea), notice: "Idea updated!"
    else
      render :edit
    end
  end

  def show
    @idea = Idea.find params[:id]
  end

  def destroy
    @idea = Idea.find params[:id]
    @idea.destroy
    redirect_to ideas_path
  end

end
