class UserNotificationService
  def initialize(user)
    @user = user
  end

  def notify target_id
    Activity.create(
      :user_id => @user.id,
        :target_id => target_id, :action_type => "new_category")
  end
end
