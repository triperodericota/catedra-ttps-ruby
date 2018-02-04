class StudentsGradesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_student_grade, only: [:update]

  def new
    evaluation = Evaluation.find(params[:id])
    @student_grade = StudentGrade.new
    @student_grade.evaluation = evaluation
    @course = evaluation.course
  end

  def create
    evaluation = Evaluation.find(params[:id])
    @student_grade = StudentGrade.new(student_grade_params)
    @student_grade.evaluation = evaluation
    p @student_grade
    respond_to do |format|
      if @student_grade.save
        format.html { redirect_to course_evaluations_url(evaluation.course, evaluation), notice: 'La nota fue cargada correctamente!' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    evaluation = params[:id]
    respond_to do |format|
      if @student_grade.update(student_grade_params)
        format.html { redirect_to course_evaluations_url(evaluation.course, evaluation), notice: 'La nota fue modificada correctamente' }
      else
        format.html {render :edit}
      end
    end
  end

  def edit
    @student_grade = StudentGrade.find_or_initialize_by(evaluation_id: params[:id], student_id: params[:student_grade][:student_id])
    p @student_grade
    @course = @student_grade.evaluation.course
    unless @student_grade.id.nil?
      p @student_grade.id
      respond_to do |format|
        format.js
      end
    end
  end

  private

  def set_student_grade
    StudentGrade.find(params[:id])
  end

  def student_grade_params
    params.require(:student_grade).permit(:student_id, :grade)
  end

end

