# frozen_string_literal: true

class PostComment < ApplicationRecord
  belongs_to :user, class_name: 'User'
  belongs_to :post
  has_ancestry
  validates :content, length: { minimum: 5, maximum: 400 }
  scope :root_comments, -> { where(ancestry: '/') }
  scope :recent_comments, -> { order(created_at: :desc) }
  delegate :email, to: :user, prefix: true

  def comments
    children.recent_comments
  end
end
