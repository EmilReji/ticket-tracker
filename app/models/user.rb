class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  has_secure_password validations: false

  validates :password, presence: true, on: :create, length: {minimum: 5}
  validates :password, confirmation: { case_sensitive: true }
end
