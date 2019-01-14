class EventPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.nil? or (user and !user.admin?)
        scope.includes(:event_image, :event_files, :availability, :category)
             .where('availabilities.start_at >= ?', Time.now)
             .order('availabilities.start_at ASC')
             .references(:availabilities)
      else
        scope.includes(:event_image, :event_files, :availability, :category)
             .references(:availabilities)
      end
    end
  end

  def create?
    user.admin?
  end

  def update?
    create?
  end

  def destroy?
    create?
  end
end
