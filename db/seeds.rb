# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

require 'faker'

#courses
#
Course.destroy_all
Course.create(year: 2016)
Course.create(year: 2017)

first_names = ['Juan', 'Tomas', 'Leo', 'Fabian', 'Maria Florencia','Julia', 'Graciela', 'Martina', 'Eduardo', 'Andres', 'Dario', 'Agustin', 'Camila', 'Paula', 'Leonor', 'Gaston' ]
last_names = ['Gonzalez', 'Perez', 'Alzuet', 'Pereyra', 'Sava', 'Romero', 'Casamiquela', 'Micchia', 'Rios', 'Flores', 'Solari', 'Iorio', 'Crespo']

Course.all.each do |course|
  puts "load students for #{course.to_s}"

  10.times do
    first_name = first_names.sample(rand(0...15)).sample
    last_name = last_names.sample(rand(1...11)).sample
    student = Student.create(first_name: first_name, last_name: last_name, dni: Faker::Number.unique.number(8), number: "#{Faker::Number.number(5)}/#{Faker::Number.digit}", email: Faker::Internet.unique.free_email)
    puts "\n Student: #{student.dni}"
    course.students << student
  end

  puts "\n load evaluations for #{course.to_s}"
  month = 9
  3.times do |i|
    evaluation = Evaluation.create(title: "Examen #{i+1}", approbation_grade: rand(4...10), date: Time.new(course.year, month, rand(1...30)), course: course)
    month = month + 1
    puts "\n Evaluation: #{evaluation.title}"

    presents_students = evaluation.course.students.sample(rand(7...10))
    presents_students.each do |student|
      student.student_grades << StudentGrade.create(evaluation: evaluation, grade: rand(0...10))
    end

  end

end

User.create(first_name: 'Nicolas', last_name: 'Mc Cormack', email: 'admin@mail.com', password: 'adminadmin')