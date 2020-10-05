class Classroom < ApplicationRecord
  # teacherとの親子関係
  has_many :teachers
  # childrenとの親子関係
  has_many :children
end
