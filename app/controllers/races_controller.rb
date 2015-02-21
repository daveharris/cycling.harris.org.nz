class RacesController < ApplicationController
  before_action :set_race, only: [:show, :edit, :update, :destroy]

  # GET /races
  def index
    @races = Race.all
  end

  # GET /races/1
  def show
    @chart_data = @race.result_duration_over_time
  end

  # GET /races/new
  def new
    @race = Race.new
  end

  # GET /races/1/edit
  def edit
  end

  # POST /races
  def create
    @race = Race.new(race_params)

    if @race.save
      redirect_to @race, notice: 'Race was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /races/1
  def update
    if @race.update(race_params)
      redirect_to @race, notice: 'Race was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /races/1
  def destroy
    @race.destroy
    redirect_to races_url, notice: 'Race was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_race
      @race = Race.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def race_params
      params.require(:race).permit(:name, :distance)
    end
end
