class Ticket < ApplicationRecord
  belongs_to :project
  has_many :ticket_tags, dependent: :delete_all
  has_many :tags, through: :ticket_tags
end

