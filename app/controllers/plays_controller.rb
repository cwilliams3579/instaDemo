class PlaysController < ApplicationController
  before_action :find_play, only: [:show, :edit, :update, :destroy]
  def index
    @plays = Play.all.order("created_at DESC")
  end

  def new
    @play = Play.new
  end

  def create
    @play = Play.new(play_params)
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

  end

  def update
    if @play.update(play_params)
      flash[:notice] = "Successfully updated"
      redirect_to plays_path
    else
      render 'edit'
    end
  end

  def show
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
    params.require(:play).permit(:title, :description, :director)
  end
end
