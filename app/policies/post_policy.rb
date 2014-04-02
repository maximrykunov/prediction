class PostPolicy < ApplicationPolicy
  attr_reader :user, :record
  
  class Scope < Struct.new(:user, :scope)
    def resolve
      if user.admin?
        scope.all
      else
        scope.by_user(user)
      end
    end
  end

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def create?
    true
  end

  def new?
    create?
  end

  def update?
    user.admin? or owner?
  end

  def edit?
    update
  end

  def destroy?
    user.admin? or owner?
  end

  private

  def owner?
    record.user == user
  end

end