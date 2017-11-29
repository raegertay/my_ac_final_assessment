class Note < ApplicationRecord

  validates :title, presence: true

  belongs_to :user
  has_many :likes, dependent: :destroy

  def liked?(user)
    likes.exists?(user_id: user.id)
  end

  def total_likes
    likes.count
  end

end
