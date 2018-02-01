require 'test_helper'

class StudentTest < ActiveSupport::TestCase

  setup do
    @perez = students(:perez)
    @gonzalez = students(:gonzalez)
    @new_student = Student.new(first_name: 'Matin', last_name: 'Curuchet', dni: 41034784, number: '47841/8', email: 'curu@gmail.com')
  end

  test "should valid student with all attributes" do
    assert @perez.valid?
    assert @gonzalez.valid?
    assert @new_student.valid?
  end

  test "should not valid student without all required attributes" do
    assert_not Student.new.valid?
    assert_not Student.new(first_name: 'Matin', last_name: 'Curuchet', dni: 41034784).valid?
    assert_not Student.new(first_name: 'Matin', last_name: 'Curuchet', email: 'curu@gmail.com').valid?
    assert_not Student.new(first_name: 'Matin', dni: 41034784, email: 'curu@gmail.com').valid?
    assert_not Student.new(last_name: 'Curuchet', dni: 41034784, number: '47841/8', email: 'curu@gmail.com').valid?
    assert Student.new(first_name: 'Matin', last_name: 'Curuchet', dni: 41034784, email: 'curu@gmail.com').valid?
  end

  test "should valid adding grade for evaluation" do
    assert_equal(3, @perez.evaluations.size)
    StudentGrade.create(grade:8, evaluation: evaluations(:fourth_evaluation), student: @perez)
    assert_equal(4, @perez.evaluations.size)
  end

  test "should valid deleting student and its associated grades" do
    id = @perez.id
    @perez.destroy
    grades = StudentGrade.where('student_id = ?', id)
    assert_empty grades
  end

  test "should valid deleting student and inscription in his/her courses" do
    student = @perez.dup
    courses = @perez.courses
    @perez.destroy
    courses.each do |c|
      assert_not c.students.include? student
    end
  end

  test "should valid grade in" do
    first = evaluations(:first_evaluation)
    second = evaluations(:second_evaluation)
    assert_equal(10, @perez.grade_in?(first))
    assert_equal(5, @gonzalez.grade_in?(first))
    assert_equal(-2, @gonzalez.grade_in?(second))
    assert_equal("Ausente",@new_student.grade_in?(second))
  end


end
