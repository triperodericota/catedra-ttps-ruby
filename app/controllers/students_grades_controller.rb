class StudentsGradesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_evaluation_student_grade
  before_action :student_param, only: [:edit, :load_grade]
  before_action :grade_param, only: [:load_grade]

  def new
    @course = @evaluation.course
    @student_grade = StudentGrade.new(evaluation: @evaluation)
  end

  def load_grade
    @student_grade = StudentGrade.find_or_initialize_by(evaluation: @evaluation, student: @student)
    @student_grade.grade = @grade
    respond_to do |format|
      if @student_grade.save
        format.html { redirect_to course_evaluations_url(@evaluation.course, @evaluation), notice: 'La nota fue cargada correctamente!' }
      else
        format.html { render :new }
      end
    end
  end

  def edit
    @student_grade = StudentGrade.find_or_initialize_by(evaluation: @evaluation, student: @student)
    @course = @evaluation.course
    respond_to do |format|
      format.js
    end
  end

  private

  def set_evaluation_student_grade
    @evaluation = Evaluation.find(params[:id])
  end

  def student_param
    @student = Student.find(params[:student_grade][:student_id])
  end

  def grade_param
    @grade = params[:student_grade][:grade]
  end

end

