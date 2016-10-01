class WikiPolicy < ApplicationPolicy

  def edit?
    user.admin? || (record.user == user)
  end

  def update?
    edit?
  end

  def destroy?
    user.admin? || (record.user == user)
  end
end
