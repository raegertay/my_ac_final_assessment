class PagesController < ApplicationController

  def dashboard
    @notes = Note.all
    @note = Note.new
  end

end
