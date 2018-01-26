require 'test_helper'

class CourseTest < ActiveSupport::TestCase

  setup do
    @course_one = courses(:course_one)
    @course_two = courses(:course_two)
  end

  test "should not valid course without year attribute" do
    assert_not Course.new.valid?
  end

  test "should valid course with year attribute" do
    assert Course.new(year: Time.now.year).valid?
  end

  test "should not valid incorrectly year's format" do
    assert_not Course.new(2).valid?
    assert_not Course.new(457).valid?
    assert_not Course.new(-2017).valid?
    assert_not Course.new(1987).valid?
  end

  test "should valid correctly year's format" do
    assert @course_one.valid?
    assert @course_two.valid?
    assert Course.new(year: 2018).valid?
  end

  test "should not valid year out of accepted range" do
    assert_not Course.new(2013).valid?
    assert_not Course.new(2023).valid?
    assert Course.new(year: 2014).valid?
    assert Course.new(year: 2021).valid?
  end

  test "should not valid already exist course" do
    assert_not Course.new(year: 2016).valid?
    assert_not Course.new(year: 2017).valid?
  end

  test "should valid adding associated students" do
    assert_empty @course_one.students
    @course_one.students << students(:perez)
    assert_not_empty @course_one.students
  end

  test "should valid deleting course and its associated students" do
    @course_one.students << students(:perez)
    id = @course_one.id
    @course_one.destroy
    course_one_students = Student.where(course_id: id)
    assert course_one_students.empty?
  end

  test "should valid adding associated evaluations" do
    assert_equal(1,@course_one.evaluations.size)
    @course_one.evaluations << Evaluation.new(title: 'new evaluation', approbation_grade: 6, date: Time.new(2016))
    assert_equal(2,@course_one.evaluations.size)
  end

  test "should valid deleting course and its associated evaluations" do
    id = @course_one.id
    @course_one.destroy
    course_one_evaluations = Evaluation.where(course_id: id)
    assert course_one_evaluations.empty?
  end


end
