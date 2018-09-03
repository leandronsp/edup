class Course < ApplicationRecord
  has_many :lessons, dependent: :delete_all
  scope :published, -> { where(published: true) }
end
