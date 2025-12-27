class Result
  attr_reader :post, :error

  def initialize(success:, post: nil, error: nil)
    @success = success
    @post = post
    @error = error
  end

  def success?
    @success
  end

  def self.success(post: nil)
    new(success: true, post: post, error: nil)
  end

  def self.failure(error:, post: nil)
    new(success: false, post: post, error: error)
  end
end
