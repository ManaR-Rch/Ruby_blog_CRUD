class User < ApplicationRecord
  has_many :posts, dependent: :restrict_with_error
  has_many :comments, dependent: :restrict_with_error

  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "invalid email" }, uniqueness: true
  validates :role, inclusion: { in: %w(member admin), message: "%{value} is not a valid role" }
end
