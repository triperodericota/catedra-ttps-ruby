require 'test_helper'

class EvaluationTest < ActiveSupport::TestCase

  setup do
    @first = evaluations(:first_evaluation)
    @second = evaluations(:second_evaluation)
    @third = evaluations(:third_evaluation)
    @new_evaluation = Evaluation.new(title:'new_evaluation', approbation_grade: 6, date: Time.new(2016), course: courses(:course_one))
  end

  test "should valid evaluation with all attributes" do
    assert @first.valid?
    assert @second.valid?
    assert @new_evaluation.valid?
  end

  test "should not valid evaluation without all attributes" do
    assert_not Evaluation.new(title:'new_evaluation', date: Time.new(2016), course_id: courses(:course_one)).valid?
    assert_not Evaluation.new(title:'new_evaluation', approbation_grade: 6, date: Time.new(2016)).valid?
    assert_not Evaluation.new(title:'new_evaluation', approbation_grade: 6, course_id: courses(:course_one)).valid?
    assert_not Evaluation.new(approbation_grade: 6, date: Time.new(2016), course_id: courses(:course_one)).valid?
  end

  test "should not valid evaluation with different date to year's course" do
    assert_equal(@first.date.year, @first.course.year)
    assert_equal(@second.date.year, @second.course.year)
    assert_equal(@new_evaluation.date.year, @new_evaluation.course.year)
    @new_evaluation.date = Time.new(2018)
    assert_not @new_evaluation.valid?
    assert_not_equal(@new_evaluation.date.year, @new_evaluation.course.year)
    @new_evaluation.date = Time.new(2016)
  end

  test "should valid amount of approved" do
    assert_equal(1, @first.amount_of_approved?)
    assert_equal(0, @second.amount_of_approved?)
    assert_equal(2, @third.amount_of_approved?)
  end

  test "should valid amount of disapproved" do
    assert_equal(1, @first.amount_of_disapproved?)
    assert_equal(2, @second.amount_of_disapproved?)
    assert_equal(0, @third.amount_of_disapproved?)
  end

  test "should valid amount of absentees" do
    course = courses(:course_one)
    course.students << students(:perez) << students(:gonzalez)
    assert_equal(0,@first.amount_of_absentees?)
    course.evaluations << @new_evaluation
    assert_equal(2,@new_evaluation.amount_of_absentees?)
  end

  test "should valid approval percentage" do
    course_one = courses(:course_one)
    course_two = courses(:course_two)
    course_one.students = course_two.students  << students(:perez) << students(:gonzalez)
    assert_equal(0.5,@first.approval_percentage?)
    assert_equal(0, @second.approval_percentage?)
    assert_equal(1, @third.approval_percentage?)
    course_one.evaluations << @new_evaluation
    assert_equal(0,@new_evaluation.approval_percentage?)
  end

  test "should valid adding students grades of evaluation" do
    assert_equal(2, @first.student_grade.size)
    assert_empty @new_evaluation.student_grade
    @new_evaluation.student_grade << StudentGrade.new(grade: 8, evaluation: @new_evaluation, student: students(:perez))
    assert_not_empty @new_evaluation.student_grade
  end

  test "should valid deleting evaluation and its associated students grades" do
    id = @first.id
    @first.destroy
    assert_empty StudentGrade.where('evaluation_id = ?', id)
  end

end
