class Classroom < ApplicationRecord
  # teacherとの親子関係
  has_many :teachers
  accepts_nested_attributes_for :teachers
  # childrenとの親子関係
  has_many :children
  accepts_nested_attributes_for :children


  # 保護者・保育者・園児一覧のsearch
  def self.search(search)
    return Classroom.all unless search
    Classroom.where(['class_name LIKE?', "%#{search}%"])
  end
end
