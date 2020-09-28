class School < ApplicationRecord
  # parentとの親子関係
  has_many :parents, dependent: :destroy
  # teacherとの親子関係
  has_many :teacher, dependent: :destroy
end
