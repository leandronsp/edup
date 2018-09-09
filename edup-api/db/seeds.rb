# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

student_role = RoleService.create_role('student')
publisher_role = RoleService.create_role('publisher')

student = User.create(email: 'student@example.com', password: 'pa$$w0rd', password_confirmation: 'pa$$w0rd')
publisher = User.create(email: 'publisher@example.com', password: 'pa$$w0rd', password_confirmation: 'pa$$w0rd')

RoleService.attach(student_role, student)
RoleService.attach(publisher_role, publisher)

ruby_course = Course.create(name: 'Ruby programming', published: true)
node_course = Course.create(name: 'Node programming')
java_course = Course.create(name: 'Java programming')

Lesson.create(course: ruby_course, name: 'Installation')
Lesson.create(course: ruby_course, name: 'Basics')
Lesson.create(course: ruby_course, name: 'Threading')
Lesson.create(course: node_course, name: 'Installation')
