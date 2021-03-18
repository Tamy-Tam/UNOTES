class YcoursePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    record.visible? || record.user == user
  end

  def show?
    record.visible? || record.user == user
  end

  def create?
    return true
  end

  def destroy?
    record.user == user
  end
end
