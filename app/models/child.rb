class Child < ApplicationRecord
  # parentとの親子関係
  belongs_to :parent
  # classroomとの親子関係
  belongs_to :classroom
  # attendanceとの子孫関係
  has_many :attendances, dependent: :destroy
  accepts_nested_attributes_for :attendances

  enum gender: { man: 0, woman: 1}
end
