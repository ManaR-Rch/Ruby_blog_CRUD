class User < ApplicationRecord
  enum role: { member: 0, admin: 1 }, _default: :member

  has_many :posts, dependent: :restrict_with_error
  has_many :comments, dependent: :restrict_with_error

  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "invalid email" }, uniqueness: true
end
