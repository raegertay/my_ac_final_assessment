class NoteMailer < ApplicationMailer

  def like_notice(user, note)
    @user = user
    @note = note
    mail(to: @user.email, subject: 'Your note has been liked!')
  end

end
