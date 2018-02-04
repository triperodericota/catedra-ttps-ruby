class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy, :evaluations_grades]

  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.order(:year)
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    @course = Course.find(params[:id])
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
    @course = Course.find(params[:id])
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'La cursada fue creada correctamente!' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'La cursada fue modificada correctamente!' }
      else
        format.html { render :edit } end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'La cursada fue eliminada correctamente!' }
    end
  end

  def evaluations_grades
    @grades = {}
    @course.students.collect do |s|
        @grades[s.id] = []
        @course.evaluations.each do |e|
          evaluation_grade = StudentGrade.find_or_initialize_by(evaluation: e,student: s)
          @grades[s.id] << evaluation_grade
        end
    end
    p @grades
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
      @students_grades = StudentGrade.where(evaluation: @course.evaluations)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:year)
    end
end
