class PagesController < ApplicationController

  def dashboard
    if user_signed_in?
      @notes = Note.all
    else
      @notes = Note.all
    end
    @users = User.where.not(id: current_user)
    @note = Note.new
  end

end
