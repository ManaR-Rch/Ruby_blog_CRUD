module Posts
  class Unpublish < ApplicationService
    def initialize(post:)
      @post = post
    end

    def call
      @post.update(published_at: nil, published_by: nil)

      if @post.saved_changes.any?
        Result.success(post: @post)
      else
        Result.failure(error: "Failed to unpublish post.", post: @post)
      end
    end
  end
end
