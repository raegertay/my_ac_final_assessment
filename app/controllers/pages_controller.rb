class PagesController < ApplicationController

  def dashboard
    @notes = Note.all
  end

end
