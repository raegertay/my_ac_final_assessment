class UserNamePresenter

  # def initialize(user)
  #   @user = user
  # end

  def name(user)
    user.email.split('@')[0]
  end

end
