class Post < ApplicationRecord
  belongs_to :user
  belongs_to :published_by, class_name: "User", optional: true
  has_many :comments, dependent: :destroy
  has_one_attached :cover_image

  validates :title, presence: true, length: { minimum: 5, maximum: 120, message: "must be between 5 and 120 characters" }
  validates :body, presence: true
  validates :slug, uniqueness: { scope: :user_id, message: "must be unique per user" }, allow_nil: true
  validates :cover_image, content_type: { in: %w(image/jpeg image/png image/webp), message: "must be JPEG, PNG, or WebP" }, size: { less_than: 5.megabytes, message: "must be less than 5MB" }, allow_nil: true

  before_validation :generate_slug

  
  scope :published, -> { where.not(published_at: nil) }
  scope :drafts, -> { where(published_at: nil) }
  scope :recent, -> { order(created_at: :desc) }
  scope :by_author, ->(user_id) { where(user_id: user_id) }
  scope :search, ->(query) { where("title LIKE ? OR body LIKE ?", "%#{query}%", "%#{query}%") if query.present? }

  def published?
    published_at.present?
  end

  def publish!
    update(published_at: Time.current)
  end

  def to_param
    slug || id
  end

  private

  def generate_slug
    return if title.blank?
    self.slug = title.downcase.parameterize
  end
end
