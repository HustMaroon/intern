class Micropost < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validate  :picture_size
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :shares, dependent: :destroy

  def liked_by?(user)
    likes.each do |like|
      return like.user==user
    end
  end
  private
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end
