class ResultsController < ApplicationController
  before_action :set_result, only: [:show, :edit, :update, :destroy]

  # GET /results
  def index
    @results = Result.all
  end

  # GET /results/1
  def show
  end

  # GET /results/new
  def new
    @result = Result.new
  end

  # GET /results/1/edit
  def edit
  end

  # POST /results
  def create
    @result = Result.new(result_params)

    if @result.save
      redirect_to @result, notice: 'Result was successfully created.'
    else
      render :new
    end
  end

  def csv
    if params.include?(:file) && current_user.present?
      Result.from_csv(params[:file].tempfile, current_user)
      redirect_to results_path, notice: 'File successfully imported!'
    else
      redirect_to results_path, notice: 'File failed imported. Please check the logs and that you are signed in!'
    end
  end

  def strava
    if params.include?(:race_id) && params.include?(:strava_activity_id) && current_user.present?
      result = Result.from_strava(params[:strava_activity_id], params[:race_id], current_user)
      redirect_to results_path, notice: "#{view_context.link_to('Strava activity', result)} successfully imported!".html_safe
    else
      redirect_to results_path, notice: 'Strava activity failed imported. Please check the logs and that you are signed in!'
    end
  end

  # PATCH/PUT /results/1
  def update
    if @result.update(result_params)
      redirect_to @result, notice: 'Result was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /results/1
  def destroy
    @result.destroy
    redirect_to results_url, notice: 'Result was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_result
      @result = Result.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def result_params
      params.require(:result).permit(:user_id, :race_id, :date, :comment, :url)
    end
end
