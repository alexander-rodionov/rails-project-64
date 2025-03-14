class PostComment < ApplicationRecord
  belongs_to :creator, class_name: "User"
  belongs_to :post
  has_ancestry
  scope :root_comments, -> { where(ancestry: "/") }


  def creator_email
    self.creator.email
  end

  def get_comments
    self.children.order(created_at: :desc)
  end

end

