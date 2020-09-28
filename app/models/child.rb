class Child < ApplicationRecord
  # parentとの親子関係
  belongs_to :parent
  # attendanceとの子孫関係
  has_many :attendances, dependent: :destroy
  accepts_nested_attributes_for :attendances, allow: true
end
