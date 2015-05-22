class GalleryPolicy < ApplicationPolicy
  def create?
    user.present? && (record.user == user || user.admin?)
  end

  def new?
    create?
  end
end