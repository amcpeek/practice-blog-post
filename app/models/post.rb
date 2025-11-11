class Post < ApplicationRecord
  belongs_to :author, class_name: "User"
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true

  def published?
    published_at.present?
  end
end
