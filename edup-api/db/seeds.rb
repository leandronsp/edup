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

ruby_course = PublisherService.create_course('Ruby programming')
node_course = PublisherService.create_course('Node programming')

PublisherService.create_lesson(ruby_course, 'Installation')
PublisherService.create_lesson(ruby_course, 'Basics')
PublisherService.create_lesson(ruby_course, 'Threading')
PublisherService.create_lesson(ruby_course, 'More')

PublisherService.create_lesson(node_course, 'Installation')
PublisherService.create_lesson(node_course, 'Basics')
PublisherService.create_lesson(node_course, 'Prototype')
