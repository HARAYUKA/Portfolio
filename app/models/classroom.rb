class Classroom < ApplicationRecord
  # teacherとの親子関係
  has_many :teachers
  accepts_nested_attributes_for :teachers
  # childrenとの親子関係
  has_many :children
  accepts_nested_attributes_for :children

end
