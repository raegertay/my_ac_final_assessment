class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]

  has_many :notes, dependent: :destroy

  has_many :followings, foreign_key: :follower_id, dependent: :destroy
  has_many :followees, through: :followings

  has_many :inverse_followings, class_name: 'Following', foreign_key: :followee_id, dependent: :destroy
  has_many :followers, through: :inverse_followings

  has_many :likes, dependent: :destroy

  def follow(user)
    followings.create(followee: user)
  end

  def unfollow(user)
    followees.destroy(user)
  end

  def following?(user)
    followees.exists?(user.id)
  end

  def followee_notes
    ids_to_include = self.followees.ids + [self.id]
    Note.where(user_id: ids_to_include).order(created_at: :desc)
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      # user.name = auth.info.name   # assuming the user model has a name
      # user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

end
