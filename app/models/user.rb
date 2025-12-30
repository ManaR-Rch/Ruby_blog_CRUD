class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :restrict_with_error
  has_many :comments, dependent: :restrict_with_error

  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "invalid email" }, uniqueness: true
  validates :role, inclusion: { in: %w(member admin), message: "%{value} is not a valid role" }
end
