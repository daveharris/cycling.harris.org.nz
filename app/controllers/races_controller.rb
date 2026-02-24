class RacesController < ApplicationController
  before_action :set_race, only: %i[show edit update destroy]

  def index
    @races = Race.alphabetical
  end

  def show
    @results = @race.results
      .rider(Current.user)
      .date_desc.load

    @chart_data = @race.result_duration_over_time(Current.user) if @results.any?
  end

  def new
    @race = Race.new
  end

  def edit
  end

  def create
    @race = Race.new(race_params)

    if @race.save
      redirect_to @race, notice: "#{@race} was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @race.update(race_params)
      redirect_to @race, notice: "#{@race} was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @race.destroy!
    redirect_to races_path, notice: "#{@race} was successfully destroyed.", status: :see_other
  end

  private

  def set_race
    @race = Race.find_by_slug!(params.require(:id))
  end

  def race_params
    params.expect(race: [:name, :distance])
  end
end
