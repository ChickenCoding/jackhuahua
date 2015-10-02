class EventPolicy < ApplicationPolicy
  def join?
    user.present?
  end
end
