require 'test_helper'

class StudentGradeTest < ActiveSupport::TestCase

  setup do
    @perez_first = student_grades(:perez_first)
    @gonzalez_first = student_grades(:gonzalez_first)
    @gonzalez_second = student_grades(:gonzalez_second)
    @perez_third = student_grades(:perez_third)
  end

  test "should valid student's grade with all attributes" do
    assert @perez_first.valid?
    assert @gonzalez_second.valid?
    assert StudentGrade.new(evaluation: evaluations(:fourth_evaluation), student: students(:perez), grade: 6).valid?
  end

  test "should not valid student's grade without all attributes" do
    assert_not StudentGrade.new.valid?
    assert_not StudentGrade.new(evaluation: evaluations(:first_evaluation)).valid?
    assert_not StudentGrade.new(student: students(:perez)).valid?
    assert_not StudentGrade.new(grade: 8).valid?
    assert_not StudentGrade.new(student: students(:perez), grade: 9).valid?
    assert_not StudentGrade.new(evaluation: evaluations(:first_evaluation), grade: 6).valid?
  end

  test "should valid approved?" do
    assert_not @gonzalez_first.approved?
    assert @perez_first.approved?
    assert_not @gonzalez_second.approved?
    assert @perez_third.approved?
  end

end
