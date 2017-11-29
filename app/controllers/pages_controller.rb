class PagesController < ApplicationController

  def dashboard
    @note = Note.new
    @notes = user_signed_in? ? current_user.followee_notes : Note.all.order(created_at: :desc)
    @users = User.where.not(id: current_user)
  end

end
