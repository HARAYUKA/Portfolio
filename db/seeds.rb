# coding: utf-8

# ひよこクラスに3名の先生・5名の親・5名の子供作成
classroom_id = 1
Classroom.create!(class_name: "ひよこ")

Teacher.create!(name: "管理者",
             email: "admin@email.com",
             password: "password",
             password_confirmation: "password",
             classroom_id: classroom_id,
             admin: true)

3.times do |n|
  name  = Faker::Name.name
  email = "teacher#{n+1}@email.com"
  password = "password"
  Teacher.create!(name: name,
              email: email,
              password: password,
              password_confirmation: password,
              classroom_id: classroom_id)
end
puts 'ひよこ先生作成'
    
5.times do |n|
  name  = Faker::Name.name
  email = "parent#{n+1}@email.com"
  password = "password"
  Parent.create!(name: name,
                email: email,
                password: password,
                password_confirmation: password)
end
puts 'ひよこ親作成'

5.times do |n|
  parent_id = n + 1
  Child.create!(parent_id: parent_id,
              classroom_id: classroom_id)
end
puts 'ひよこ子供作成'

# あひるクラスに3名の先生・5名の親・5名の子供作成
classroom_id = 2
Classroom.create!(class_name: "あひる")

n = 3
while n < 7 do
  name  = Faker::Name.name
  email = "teacher#{n+1}@email.com"
  password = "password"
  Teacher.create!(name: name,
              email: email,
              password: password,
              password_confirmation: password,
              classroom_id: classroom_id)
  n += 1
end
puts 'あひる先生作成'

n = 5
while n < 11 do
  name  = Faker::Name.name
  email = "parent#{n+1}@email.com"
  password = "password"
  Parent.create!(name: name,
                email: email,
                password: password,
                password_confirmation: password)
  n += 1
end
puts 'あひる親作成'

n = 5
while n < 11 do
  parent_id = n + 1
  Child.create!(parent_id: parent_id,
              classroom_id: classroom_id)
  n += 1
end
puts 'あひる子供作成'

# ぺんぎんクラスに3名の先生・5名の親・5名の子供作成
classroom_id = 3
Classroom.create!(class_name: "ぺんぎん")

n = 7
while n < 11 do
  name  = Faker::Name.name
  email = "teacher#{n+1}@email.com"
  password = "password"
  Teacher.create!(name: name,
              email: email,
              password: password,
              password_confirmation: password,
              classroom_id: classroom_id)
  n += 1
end
puts 'ぺんぎん先生作成'

n = 11
while n < 17 do
  name  = Faker::Name.name
  email = "parent#{n+1}@email.com"
  password = "password"
  Parent.create!(name: name,
                email: email,
                password: password,
                password_confirmation: password)
  n += 1
end
puts 'ぺんぎん親作成'

n = 11
while n < 17 do
  parent_id = n + 1
  Child.create!(parent_id: parent_id,
              classroom_id: classroom_id)
  n += 1
end
puts 'ぺんぎん子供作成'