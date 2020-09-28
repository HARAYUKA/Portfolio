class Attendance < ApplicationRecord
  # childとの子孫関係
  belongs_to :child
end
