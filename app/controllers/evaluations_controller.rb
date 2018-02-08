class EvaluationsController < ApplicationController
  before_action :set_evaluations
  before_action :set_evaluation, only: [:show_grades, :show, :edit, :update, :destroy, :load_grades]

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
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /evaluations/1
  # PATCH/PUT /evaluations/1.json
  def update
    respond_to do |format|
      if @evaluation.update(evaluation_params)
        format.html { redirect_to course_evaluations_url, notice: 'La evaluación fue modificada correctamente!' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /evaluations/1
  # DELETE /evaluations/1.json
  def destroy
    @evaluation.destroy
    respond_to do |format|
      format.html { redirect_to course_evaluations_url, notice: 'La evaluación fue eliminada correctamente!' }
    end
  end

  def show_grades
    @evaluation.course.students  do |student|
      @evaluation.student_grade.find_or_initialize_by(student: student)
    end
  end

  def load_grades
    respond_to do |format|
      begin
        if @evaluation.update(student_grade_params) || @evaluation.save(student_grade_params)
          format.html { redirect_to(course_evaluations_url(@evaluation.course, @evaluation), notice: 'Las notas fueron cargadas correctamente!') }
       else
          format.html { render :show_grades }
        end
    rescue
        format.html { redirect_to(course_evaluations_url(@evaluation.course, @evaluation), notice: 'Las notas no pudieron ser cargadas, por favor intente más trade!') }
      end
    end
  end

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

    def student_grade_params
      params.require(:evaluation).permit(:id, {student_grade_attributes: [:student_id, :grade, :id]})
    end
end
