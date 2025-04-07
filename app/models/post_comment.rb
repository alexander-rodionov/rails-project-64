# frozen_string_literal: true

class PostComment < ApplicationRecord
  # Associations
  belongs_to :user, class_name: 'User'
  belongs_to :post
  has_ancestry

  # Validations
  validates :content, length: { minimum: 5, maximum: 400 }

  # Scopes
  scope :root_comments, -> { where(ancestry: '/') }
  scope :recent_comments, -> { order(created_at: :desc) }

  # Methods
  def comments
    children.recent_comments
  end
end
