class NotesController < ApplicationController

  before_action :authenticate_user!

  def create
    @note = current_user.notes.build(note_params)
    if @note.save
      flash[:notice] = 'Note created successfully'
      redirect_to root_path
    else
      flash[:alert] = 'Something went wrong. Please try again.'
      redirect_to root_path
    end
  end

  def destroy
    @note = Note.find(params[:id])
    @note.destroy
    flash[:notice] = 'Note deleted'
    redirect_to root_path
  end

  private

  def note_params
    params.require(:note).permit(:title, :body)
  end

end
