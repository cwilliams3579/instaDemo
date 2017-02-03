class PlaysController < ApplicationController
  before_action :find_play, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit]
  # before_action :set_category, only: [:show, :edit, :update, :destroy]
  def index
    if params[:category].blank?
      @plays = Play.all.order("created_at DESC")
    else
      @category_id = Category.find_by(name: params[:category]).id
      @plays = Play.where(:category_id => @category_id).order("created_at DESC")
    end
  end

  def new
    @play = current_user.plays.build
    @categories = Category.all.map{ |c| [c.name, c.id] }
  end

  def create
    @play = current_user.plays.build(play_params)
    @play.category_id = params[:category_id]
    respond_to do |format|
      if @play.save
        format.html { redirect_to @play, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @play }
      else
        format.html { render :new }
        format.json { render json: @play.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @categories = Category.all.map{ |c| [c.name, c.id] }
  end

  def update
    @play.category_id = params[:category_id]
    if @play.update(play_params)
      flash[:notice] = "Successfully updated"
      redirect_to plays_path
    else
      render 'edit'
    end
  end

  def show
    if @play.reviews.blank?
      @average_review = 0
    else
      @average_review = @play.reviews.average(:rating).round(2)
    end
  end

  def destroy
    @play.destroy
    flash[:danger] = "Play have been deleted"
    redirect_to plays_path
  end

  private

  def find_play
    @play = Play.find(params[:id])
  end

  def play_params
    params.require(:play).permit(:title, :description, :director, :category_id, :play_img)
  end
end
