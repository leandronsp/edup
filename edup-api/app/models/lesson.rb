class Lesson < ApplicationRecord
  belongs_to :course
  has_one_attached :upload
end
