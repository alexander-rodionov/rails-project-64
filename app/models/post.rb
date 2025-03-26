

class Post < ApplicationRecord
  belongs_to :category
  belongs_to :user, class_name: "User"
  has_many :post_comment
  has_many :post_like
  validates :title, length: { minimum: 5, maximum: 255 }
  validates :body, length: { minimum: 200, maximum: 4000 }


  scope :latest, -> { order(created_at: :desc) }

  def likes_count
    post_like.size
  end

  def time_interval
    distance_of_time_in_words(created_at, Time.current)
  end

  def user_email
    user&.email
  end

  def get_comments
    self.post_comment.root_comments.order(created_at: :desc)
  end
end
