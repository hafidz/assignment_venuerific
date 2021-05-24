class Ability
  include CanCan::Ability

  def initialize(user)
    if user.is_admin
      can :manage, :all
    else
      can :manage, Post
    end
  end
end
