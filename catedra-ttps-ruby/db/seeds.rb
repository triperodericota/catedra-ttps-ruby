# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

#courses
#
course_2016 = Course.create(year: 2016)
course_2017 = Course.create(year: 2017)

#evaluations
#2016 course's students
random_dates_2016 = []
month = 9
4.times do |i|
  random_dates_2016 << Time.new(2016,month,rand(1..30),rand(15...19))
  month = month + 1
end
4.times do |i|
  Evaluation.create(title: "Examen #{i+1}", approbation_grade: rand(5..15) + i, date: random_dates_2016[i], course: course_2016)
end

#2017 course's students
titles_2017= ["Primer parcial(practicas 1 y 2)", "Segundo parcial(practicas 3 y 4)", "Tercer parcial(practica 5)"]
dates_2017 = [Time.new(2017,10,5,19), Time.new(2017,11,23,19), Time.new(2017,12,7,19)]
3.times do |i|
  Evaluation.create(title: titles_2017[i], approbation_grade: 9, date: dates_2017[i], course: course_2017 )
end

#students
first_names = ['Juan', 'Tomas', 'Leo', 'Fabian', 'Maria Florencia','Julia', 'Graciela', 'Martina', 'Eduardo', 'Andres', 'Dario', 'Agustin', 'Camila', 'Paula', 'Leonor', 'Gaston' ]
last_names = ['Gonzalez', 'Perez', 'Alzuet', 'Pereyra', 'Sava', 'Romero', 'Casamiquela', 'Micchia', 'Rios', 'Flores', 'Solari', 'Iorio', 'Crespo']

#2016 course's students
10.times do |i|
  course_2016.students << Student.create(first_name: first_names[i] , last_name: last_names[i], dni: rand(10000000...40000000), legajo: "#{rand(1000...15000).to_s}/#{rand(0...9)}", email: "studentmail#{i}@gmail.com")
end

#2017 course's students
10.times do |i|
  course_2017.students << Student.create(first_name: first_names[16-i] , last_name: last_names.sample, dni: rand(10000000...40000000), legajo: "#{rand(1000...15000).to_s}/#{rand(0...9)}", email: "studentmail#{i+10}@gmail.com")
end