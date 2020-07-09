class TicketsController < ApplicationController
  before_action :set_project, except: [:index]
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]

  def index # should get all tickets (rather than just tickets under one project); not nested 
    @tickets = Ticket.all
  end

  def show
  end

  def new
    @tags = Tag.all
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new(ticket_params)
    @ticket.project_id = @project.id
    
    if @ticket.save
      flash[:success] = "Your ticket was created."
      redirect_to project_ticket_path(@project, @ticket)
    else
      flash[:error] = "Your ticket wasn't created."
      #puts @ticket.errors.full_messages
      render 'new'
    end
  end

  def edit
    @tags = Tag.all
  end

  def update
    if @ticket.update(ticket_params)
      flash[:success] = "Your ticket was updated."
      redirect_to project_ticket_path(@project, @ticket)
    else
      flash[:error] = "Your ticket wasn't updated."
      render 'edit'
    end
  end

  def destroy
    @ticket.destroy
    flash[:success] = "Your ticket was deleted."
    redirect_to project_path(@project)
  end

  private

  def ticket_params
    params.require(:ticket).permit(:name, :body, :status, tag_ids: [])
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end
end
