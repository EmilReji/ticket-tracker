class Ticket < ApplicationRecord
  belongs_to :project
  
  has_many :ticket_tags, dependent: :destroy
  has_many :tags, through: :ticket_tags
  
  has_many :comments, dependent: :destroy
end

