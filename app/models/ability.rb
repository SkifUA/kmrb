class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
      user ||= User.new # guest user (not logged in)
      can :manage, User, id: user.id
      if user.admin?
        cans_by_group_admin(user).map do |can|
          next unless can[:action].present?
          can can[:action], can[:model]
        end
      end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end

  private
  def cans_by_group_admin(user)
    cans = []
    user.admin.group_admin.as_json.map do |k,v|
      if v.is_a?(Integer) && k != 'id'
        next if v < 0 || v > GroupAdmin::NUMBER_ACCESS.max
        cans << {
            action: can_actions(v),
            model: (k + 's').classify.constantize
        }
      end
    end
    cans
  end

  def can_actions(level)
    case level
      when 0
        []
      when 1
        [:read]
      when 2
        [:read, :create, :update]
      when 3
        [:manage]
      else
        []
    end

  end
end
