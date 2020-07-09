class TagsController < ApplicationController
  before_action :set_tag, only: [:edit, :update, :destroy]

  def index
    @tags_data = Tag.all.map do |tag|
      [tag, tag.tickets.length] 
    end
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)

    if @tag.save
      flash[:success] = "New tag was successfully created!"
      redirect_to tags_path
    else
      flash[:error] = "New tag wasn't created!"
      render 'new'
    end
  end

  def edit
  end

  def update
    if @tag.update(tag_params)
      flash[:success] = "Existing tag was successfully updated!"
      redirect_to tags_path
    else
      flash[:error] = "Existing tag wasn't updated!"
      render 'edit'
    end
  end

  def destroy
    @tag.destroy
    flash[:success] = "Existing tag was successfully deleted!"
    redirect_to tags_path
  end

  private

  def tag_params
    params.require(:tag).permit(:value)
  end

  def set_tag
    @tag = Tag.find(params[:id])
  end
end
