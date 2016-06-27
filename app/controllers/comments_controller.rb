class CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]

  def index
    @comments = Comment.order("created_at")
  end

  def new
    @comment = Comment.new
  end

  def show
    @comment = Comment.find params[:id]
  end

  def create
    # byebug
    @idea = Idea.find params[:idea_id]
    comment_params = params.permit(:body)
    @comment = Comment.new comment_params
    @comment.idea = @idea
    @comment.user = current_user
    if @comment.save
      redirect_to idea_path(@idea), notice: "Comment saved"
    else
      render :new
    end
  end

  def edit
    @comment = Comment.find params[:id]
    @idea = @comment.idea
  end

  def update
    @idea = Idea.find params[:idea_id]
    @comment = Comment.find params[:id]
    comment_params = params.require(:comment).permit(:body)
    if @comment.user = current_user || @idea.user == current_user
      if @comment.update comment_params
        redirect_to idea_path(@idea)
      else
        redirect_to edit_idea_comment_path(@idea, @comment)
      end
    else
      redirect_to redirect_to idea_path(@idea), notice: "You can't do this"
    end
  end

  def destroy
    @idea = Idea.find params[:idea_id]
    @comment = Comment.find params[:id]
    if @comment.user = current_user || @idea.user == current_user
      @comment.destroy
      redirect_to idea_path(@idea), notice: "Comment deleted"
    else
      redirect_to idea_path(@idea), notice: "You can't do this!"
    end
  end
end
