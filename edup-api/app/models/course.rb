class Course < ApplicationRecord
  has_many :lessons, dependent: :delete_all
  has_and_belongs_to_many :users

  scope :published, -> { where(published: true) }

  def students
    users
  end
end
