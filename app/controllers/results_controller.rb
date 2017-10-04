class ResultsController < ApplicationController
  before_action :set_result, only: [:show, :edit, :update, :destroy, :timing_team_enrich]
  before_action :require_login, except: [:index, :show]

  def index
    if params[:result]
      filter_params = result_params.keep_if{|k,v| v.present?}
      @results = Result.where(filter_params)
    elsif current_user
      @results = Result.rider(current_user)
    else
      @results = Result
    end

    @results = @results.includes(:race, :user).date_desc.decorate
  end

  def show
    @previous = @result.find_previous_result.try(:decorate)
    @personal_best = @result.find_personal_best.try(:decorate) if @result.find_personal_best != @result
  end

  def new
    @result = Result.new
  end

  def edit
  end

  def create
    @result = Result.new(result_params)

    if @result.save
      redirect_to @result, notice: 'Result was successfully created.'
    else
      render :new
    end
  end

  def csv
    if params.include?(:file)
      Result.from_csv(params[:file].tempfile, current_user)
      redirect_to results_path, notice: 'File successfully imported!'
    else
      redirect_to results_path, notice: 'File failed imported. Please check the logs and that you are signed in!'
    end
  end

  def strava
    if params.include?(:race_id) && params.include?(:strava_activity_id)
      result = Result.from_strava(params[:strava_activity_id], params[:race_id], current_user)
      redirect_to results_path, notice: "#{view_context.link_to('Strava activity', result)} successfully imported!".html_safe
    else
      redirect_to results_path, notice: 'Strava activity import failed'
    end
  end

  def timing_team
    if params.include?(:race_id) && params.include?(:url) && params[:url].include?('thetimingteam.co.nz')
      result = Result.from_timing_team(params[:url], params[:race_id], current_user)
      redirect_to results_path, notice: "#{view_context.link_to('Activity', result)} successfully imported!".html_safe
    else
      redirect_to results_path, notice: 'The Timing Team activity import failed'
    end
  end

  def timing_team_enrich
    if @result.timing_url.present? && @result.timing_url.include?('thetimingteam.co.nz')
      @result.enrich_from_timing_team
      redirect_to result_path(@result), notice: "#{view_context.link_to(@result.name, @result)} successfully enriched!".html_safe
    else
      redirect_to result_path(@result), notice: 'The Timing Team activity enrich failed'
    end
  end

  def update
    if @result.update(result_params)
      redirect_to @result, notice: 'Result was updated.'
    else
      render :edit
    end
  end

  def destroy
    @result.destroy
    redirect_to results_url, notice: 'Result was successfully destroyed.'
  end


  private

    def set_result
      @result = Result.find(params[:id]).decorate
    end

    def result_params
      params.require(:result).permit(:user_id, :race_id,
                                     :date, :comment, :timing_url, :strava_url, :wind, :position, :finishers,
                                     :duration, :duration_s, :fastest_duration, :fastest_duration_s, :median_duration, :median_duration_s)
    end
end
