class Tag < ApplicationRecord
  validates :value, presence: true, uniqueness: true

  has_many :ticket_tags, dependent: :destroy
  has_many :tickets, through: :ticket_tags
end

