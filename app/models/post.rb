

class Post < ApplicationRecord
  belongs_to :category
  belongs_to :creator, class_name: "User"
  has_many :post_comment
  has_many :post_like

  scope :latest_last, -> order(created_at: :desc)
  
  def likes_count
    post_like.size
  end

  def time_interval
    distance_of_time_in_words(created_at, Time.current)
  end

  def creator_email
    creator&.email
  end

  def get_comments
    self.post_comment.root_comments.order(created_at: :desc)
  end

end
