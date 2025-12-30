module Comments
  class Create < ApplicationService
    SPAM_KEYWORDS = [
      "viagra", "casino", "free money", "visit", "link", "http", "https", "porn", "xxx"
    ].freeze

    def initialize(user:, post:, params:)
      @user = user
      @post = post
      @params = params
    end

    def call
      body = @params[:body].to_s.strip
      return Result.failure(error: :invalid) if body.blank?
      return Result.failure(error: :spam_blocked) if spam?(body)

      comment = nil
      ActiveRecord::Base.transaction do
        comment = @post.comments.build(body: body, user: @user)
        comment.save!
      end

      Result.success(post: comment)
    rescue ActiveRecord::RecordInvalid
      Result.failure(error: :invalid)
    end

    private

    def spam?(text)
      downcased = text.downcase
      SPAM_KEYWORDS.any? { |kw| downcased.include?(kw) }
    end
  end
end
