class CommentsController < ApplicationController
  before_action :set_project
  before_action :set_ticket
  before_action :set_comment, only: [:edit, :update, :destroy]
  before_action :require_user
  before_action :require_same_user, only: [:edit, :update, :destroy]
  
  def create
    @comment = Comment.new(comment_params)
    @comment.creator = current_user
    @comment.ticket = @ticket

    if @comment.save
      flash[:success] = "The comment was created!"
      redirect_to project_ticket_path(@project, @ticket)
    else
      flash[:error] = "The comment wasn't created!"
      render "tickets/show"
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      flash[:success] = "The comment was updated!"
      redirect_to project_ticket_path(@project, @ticket)
    else
      flash[:error] = "The comment wasn't updated!"
      render "edit"
    end
  end

  def destroy
    @comment.destroy
    flash[:success] = "The comment was deleted!"
    redirect_to project_ticket_path(@project, @ticket)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_ticket
    @ticket = Ticket.find(params[:ticket_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def require_same_user
    if current_user != @comment.creator
      flash[:error] = "You must be logged in as same user as the comment creator to edit or delete it."
      redirect_to project_ticket_path(@project, @ticket)
    end
  end
end
