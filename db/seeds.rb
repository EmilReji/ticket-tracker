# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Project.all.map(&:destroy)
User.find_by(name: "testuser")&.destroy
User.find_by(name: "testuser2")&.destroy
Tag.all.map(&:destroy)

user1 = User.create(name: "testuser", email: "testuser@gmail.com", password: "testuser", password_confirmation: "testuser")
user2 = User.create(name: "testuser2", email: "testuser2@gmail.com", password: "testuser2", password_confirmation: "testuser2")

project1 = Project.create(name: "Project 1", description: "Test Project 1 Description")
project2 = Project.create(name: "Project 2", description: "Test Project 2 Description")

ticket1 = Ticket.create(name: "Ticket 1", body: "This is my first ticket for Project 1", status: "new", project: project1, creator: user1.id, assignee: user2.id)
ticket2 = Ticket.create(name: "Ticket 2", body: "This is my first ticket for Project 2", status: "new", project: project2, creator: user2.id, assignee: user1.id)

tag1 = Tag.create(value: "Tag 1")
tag2 = Tag.create(value: "Tag 2")
tag3 = Tag.create(value: "Tag 3")
ticket1.tags = [tag1, tag2]
ticket2.tags << tag3

comment1 = Comment.create(body: "This is my first comment for Ticket 1 on Project 1.", ticket: ticket1, creator: user1)
comment2 = Comment.create(body: "This is my second comment for Ticket 1 on Project 1.", ticket: ticket1, creator: user1)

