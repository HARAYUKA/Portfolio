# coding: utf-8

School.create!(school_name: "○○保育園")
school_id = 1

Teacher.create!(name: "管理者",
             email: "admin@email.com",
             password: "password",
             password_confirmation: "password",
             school_id: school_id,
             admin: true)
             
# 20.times do |n|
#   name  = Faker::Name.name
#   email = "parent#{n+1}@email.com"
#   password = "password"
#   Parent.create!(name: name,
#                email: email,
#                password: password,
#                password_confirmation: password,
#                school_id: school_id)
# end
# puts '親作成'

20.times do |n|
  name  = Faker::Name.name
  email = "teacher#{n+1}@email.com"
  password = "password"
  Teacher.create!(name: name,
              email: email,
              password: password,
              password_confirmation: password,
              school_id: school_id)
end
puts '先生作成'