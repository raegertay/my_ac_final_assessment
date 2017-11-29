class UsersController < ApplicationController

  before_action :prepare_user

  def follow
    current_user.follow(@user)
    flash[:notice] = 'Following ' + @user.name + ' now'
    redirect_to root_path
  end

  def unfollow
    current_user.unfollow(@user)
    flash[:notice] = 'Unfollowed ' + @user.name
    redirect_to root_path
  end

  private

  def prepare_user
    @user = User.find(params[:id])
  end

end
