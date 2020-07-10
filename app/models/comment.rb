class Comment < ApplicationRecord
  validates :body, presence: true

  belongs_to :ticket
  belongs_to :creator, foreign_key: :user_id , class_name: 'User'
end
