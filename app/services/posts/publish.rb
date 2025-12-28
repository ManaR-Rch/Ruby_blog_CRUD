module Posts
  class Publish < ApplicationService
    def initialize(post:, publisher:)
      @post = post
      @publisher = publisher
    end

    def call
      @post.update(
        published_at: Time.current,
        published_by: @publisher
      )

      if @post.saved_changes.any?
        Result.success(post: @post)
      else
        Result.failure(error: "Failed to publish post.", post: @post)
      end
    end
  end
end
