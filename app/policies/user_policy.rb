class UserPolicy < Struct.new(:user, :record)
  
  def index?
    user.admin?
  end

  def show?
    user.admin? or record == user
  end

  def update?
    user.admin? or post.owner?
  end
end