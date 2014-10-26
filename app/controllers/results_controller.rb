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
