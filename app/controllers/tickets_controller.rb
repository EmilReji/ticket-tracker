class TicketsController < ApplicationController
  before_action :set_project, except: [:index]
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :get_non_current_users, only: [:new, :edit]
  before_action :set_tags, only: [:index, :new, :edit]

  def index # should get all tickets (rather than just tickets under one project); not nested 
    @tickets = Ticket.all

    if params[:tag_id] # means we recieved query parameter from tags page link
      tag_id = params[:tag_id] || ''

      @tickets = @tickets.select do |ticket|
        (tag_id == '' || ticket.tags.map(&:id).include?(tag_id.to_i))
      end

      @tag_val = Tag.find(tag_id)&.value
      @tags = @tags.filter { |tag| tag.id != tag_id.to_i } 

      respond_to do |f|
        f.html
      end
    elsif params[:project] # means we recieved ajax request when filters on tickets changed and update clicked
      project_id = params[:project][:project_id] || '' 
      status = params[:project][:status] || ''
      tag_id = params[:project][:tag_id] || ''
      
      @tickets = @tickets.select do |ticket|
        (project_id == '' || ticket.project_id.to_s == project_id) && 
        (status == '' || ticket.status == status) &&
        (tag_id == '' || ticket.tags.map(&:id).include?(tag_id.to_i))
      end
    
      respond_to do |f|
         f.js
      end
    end
    # if neither exists, means simply show all tickets using basic html form
  end

  def show
  end

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new(ticket_params)
    @ticket.project_id = @project.id
    @ticket.creator = current_user.id
    
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
    params.require(:ticket).permit(:name, :body, :status, :assignee, tag_ids: [])
  end

  def set_tags
    @tags = Tag.order(:value)
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  def get_non_current_users
    @users = User.all.filter { |user| user.id != current_user.id } || []
  end
end
