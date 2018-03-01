class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    @user = User.find_by id: params[:followed_id]
    current_user.follow @user
    @user_following = current_user.active_relationships.find_by(
      followed_id: @user.id)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = Relationship.find_by(id: params[:id]).followed
    current_user.unfollow @user
    @user_follower = current_user.active_relationships.build
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  private

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t "user.please_login"
    redirect_to login_url
  end
end
