

class Post < ApplicationRecord
  belongs_to :category
  belongs_to :creator, class_name: "User"
  has_many :post_comment
  has_many :post_like
  validates :title, length: { minimum: 5, maximum: 255 }
  validates :body, length: { minimum: 200, maximum: 4000 }


  def likes_count
    self.post_like.count
  end

  def time_interval
    distance_of_time_in_words(self.created_at, Time.now)
  end

  def creator_email
    self.creator.email
  end

  def get_comments
    self.post_comment.root_comments.order(created_at: :desc)
  end

end
