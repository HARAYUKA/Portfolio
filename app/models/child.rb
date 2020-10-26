class Child < ApplicationRecord
  # parentとの親子関係
  belongs_to :parent
  # classroomとの親子関係
  belongs_to :classroom
  # attendanceとの子孫関係
  has_many :attendances, dependent: :destroy
  accepts_nested_attributes_for :attendances, allow_destroy: true

  enum gender: { man: 1, woman: 2}

end
