# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  def show?
    record.published? || own_post? || user&.admin?
  end

  def create?
    user.present?
  end

  def update?
    own_post? || user&.admin?
  end

  def destroy?
    user&.admin?
  end

  def publish?
    own_post? || user&.admin?
  end

  def unpublish?
    own_post? || user&.admin?
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user&.admin?
        scope.all
      elsif user.present?
        # Logged-in users see published posts and their own drafts
        scope.where("published_at IS NOT NULL OR (user_id = ? AND published_at IS NULL)", user.id)
      else
        # Guests see only published posts
        scope.where("published_at IS NOT NULL")
      end
    end
  end

  private

  def own_post?
    record.user_id == user&.id
  end
end
