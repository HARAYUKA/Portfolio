# coding: utf-8

Teacher.create!(name: "管理者",
             email: "admin@email.com",
             password: "password",
             password_confirmation: "password",
             admin: true)
             
20.times do |n|
  name  = Faker::Name.name
  email = "parent#{n+1}@email.com"
  password = "password"
  Parent.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
end

20.times do |n|
  name  = Faker::Name.name
  email = "teacher#{n+1}@email.com"
  password = "password"
  Teacher.create!(name: name,
              email: email,
              password: password,
              password_confirmation: password)
end