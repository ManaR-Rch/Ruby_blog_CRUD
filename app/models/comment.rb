class Comment < ApplicationRecord
  belongs_to :post, counter_cache: true
  belongs_to :user

  validates :body, presence: true, length: { minimum: 3, maximum: 500, message: "must be between 3 and 500 characters" }
end
