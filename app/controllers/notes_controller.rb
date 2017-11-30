class NotesController < ApplicationController

  before_action :authenticate_user!
  before_action :prepare_note, except: [:create]

  def create
    @note = current_user.notes.build(note_params)
    if @note.save
      flash[:notice] = 'Note created successfully'
      redirect_to root_path
    else
      # flash[:alert] = 'Something went wrong. Please try again.'
      # redirect_to root_path
      @notes = user_signed_in? ? current_user.followee_notes : Note.all.order(created_at: :desc)
      @users = User.where.not(id: current_user)
      render 'pages/dashboard'
    end
  end

  def edit; end

  def update
    if @note.update(note_params)
      flash[:notice] = 'Note updated successfully'
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @note.destroy
    flash[:notice] = 'Note deleted'
    redirect_to root_path
  end

  def like
    @note.likes.create(user: current_user)
    flash[:notice] = 'Note liked'
    NoteMailer.like_notice(@note.user, @note).deliver_later
    redirect_to root_path
  end

  def unlike
    @like = Like.find_by(note: @note, user: current_user)
    @like.destroy
    flash[:notice] = 'Note unliked'
    NoteMailer.unlike_notice(@note.user, @note).deliver_later
    redirect_to root_path
  end

  private

  def note_params
    params.require(:note).permit(:title, :body)
  end

  def prepare_note
    @note = Note.find(params[:id])
  end

end
