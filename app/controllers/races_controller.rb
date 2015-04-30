class RacesController < ApplicationController
  before_action :set_race, only: [:show, :edit, :update, :destroy]
  before_action :require_login, except: [:index, :show]

  def index
    @races = Race.all
  end

  def show
    @chart_data = @race.result_duration_over_time
  end

  def new
    @race = Race.new
  end

  def edit
  end

  def create
    @race = Race.new(race_params)

    if @race.save
      redirect_to @race, notice: "#{@race.to_s} was successfully created."
    else
      render :new
    end
  end

  def update
    if @race.update(race_params)
      redirect_to @race, notice: "#{@race.to_s} was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @race.destroy
    redirect_to races_url, notice: "#{@race.to_s} was successfully deleted."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_race
      @race = Race.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def race_params
      params.require(:race).permit(:name, :distance, :url)
    end
end
