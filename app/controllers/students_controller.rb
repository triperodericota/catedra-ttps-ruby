class StudentsController < ApplicationController
  before_action :set_students
  before_action :set_student, only: [:show, :edit, :update, :destroy]

  # GET /students
  # GET /students.json
  def index
    @students = @course.students.order(:last_name)
  end

  # GET /students/1
  # GET /students/1.json
  def show
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
  end

  # POST /students
  # POST /students.json
  def create
    @student = Student.new(student_params)
    @student.courses << Course.find(params[:course_id])
    respond_to do |format|
      if @student.save
        format.html { redirect_to course_students_url, notice: 'El alumno fue creado correctamente!' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to course_students_url(@course), notice: 'Los datos del alumno fueron modificados correctamente!' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.destroy
    respond_to do |format|
      format.html { redirect_to course_students_url(@course), notice: 'El alumno fue eliminado correctamente!' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = @course.students.find(params[:id])
    end

    def set_students
      @course = Course.find(params[:course_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:first_name, :last_name, :dni, :number, :email)
    end
end
