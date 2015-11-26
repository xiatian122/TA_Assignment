class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
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

    user ||= User.new # guest user (not logged in)

    alias_action :create, :read, :update, :destroy, :to => :crud
    alias_action :new_application, :edit_ta_application, :update_ta_application, :create_ta_application, :withdraw_student_application, :accept_ta_assignment, :reject_ta_assignment, :to => :modify_ta_application
    alias_action :edit_suggestion, :submit_ta_suggestion, :delete_suggestion, :to => :modify_ta_suggestion

    #if it's Dr. Keyser
    if user.admin?
      can :manage, :all
    #elsif it's a instructor
    elsif user.faculty?
      can :read, User, :id => user.id
      can :update, User, :id => user.id
      cannot :index, User

      can :lecturer_show, User, :id => user.id
      can :modify_ta_suggestion, User, :id => user.id

      cannot :manage, Course
      cannot :manage, StudentApplication 
      cannot :manage, ApplicationPool

    #else it's a student
    elsif user.student?
      can :read, User, :id => user.id
      can :update, User, :id => user.id
      cannot :index, User

      cannot :manage, Course
      cannot :manage, StudentApplication 
      cannot :manage, ApplicationPool

      can :modify_ta_application, User, :id => user.id
    else
      cannot :manage, :all
    end
  end
end
