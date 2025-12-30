module Posts
  class Create < ApplicationService
    def initialize(user:, params:, publish_now: false)
      @user = user
      @params = params
      @publish_now = publish_now
    end

    def call
      post = @user.posts.build(filtered_params)

      post.slug ||= post.title.to_s.parameterize.presence

      post.published_at = Time.current if @publish_now

      if post.save
        Result.success(post: post)
      else
        Result.failure(error: post.errors.full_messages.to_sentence, post: post)
      end
    end

    private

    def filtered_params
      @params.slice(:title, :body)
    end
  end
end
