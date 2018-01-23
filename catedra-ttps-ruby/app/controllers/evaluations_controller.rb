class EvaluationsController < ApplicationController
  before_action :set_evaluations
  before_action :set_evaluation, only: [:show, :edit, :update, :destroy]

  # GET /evaluations
  # GET /evaluations.json
  def index
      @evaluations = @course.evaluations
  end

  #GET /evaluations/new
  def new
    @evaluation = Evaluation.new
  end

  def edit

  end

  # POST /evaluations
  # POST /evaluations.json
  def create
    @evaluation = Evaluation.new(evaluation_params)
    @evaluation.course = @course
    respond_to do |format|
      if @evaluation.save
        format.html { redirect_to course_evaluations_url, notice: 'La evaluacion fue creada correctamente!' }
        format.json { render :show, status: :created, location: @evaluation }
      else
        format.html { render :new }
        format.json { render json: @evaluation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /evaluations/1
  # PATCH/PUT /evaluations/1.json
  def update
    respond_to do |format|
      if @evaluation.update(evaluation_params)
        format.html { redirect_to course_evaluations_url, notice: 'La evaluación fue modificada correctamente!' }
        format.json { render :show, status: :ok, location: @evaluation }
      else
        format.html { render :edit }
        format.json { render json: @evaluation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /evaluations/1
  # DELETE /evaluations/1.json
  def destroy
    @evaluation.destroy
    respond_to do |format|
      format.html { redirect_to course_evaluations_url, notice: 'La evaluación fue eliminada correctamente!' }
      format.json { head :no_content }
    end
  end

  def new_grade

  end

  def load_grade

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_evaluation
      @evaluation = Evaluation.find(params[:id])
    end

    def set_evaluations
      @course = Course.find(params[:course_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def evaluation_params
      params.require(:evaluation).permit(:title, :approbation_grade, :date)
    end
end
