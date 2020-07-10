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
      render "ticket#show"
    end
  end

  def edit
  end

  def update
    
  end

  def destroy

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
