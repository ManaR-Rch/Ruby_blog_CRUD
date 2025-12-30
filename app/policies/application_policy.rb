# frozen_string_literal: true

class ApplicationPolicy < ActionPolicy::Base

  def index?
    user&.admin?
  end

  def show?
    true
  end

  def create?
    user.present?
  end

  def update?
    user&.admin?
  end

  def destroy?
    user&.admin?
  end
end
