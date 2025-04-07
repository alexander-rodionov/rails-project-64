# frozen_string_literal: true

class Post < ApplicationRecord
  include ActionView::Helpers::DateHelper
  belongs_to :category
  belongs_to :creator, class_name: 'User'

  has_many :post_comments

  validates :title, length: { minimum: 5, maximum: 255 }
  validates :body, length: { minimum: 200, maximum: 4000 }

  scope :latest, -> { order(created_at: :desc) }

  has_many :likes, class_name: 'PostLike', dependent: :destroy

  def time_interval
    distance_of_time_in_words(created_at, Time.current)
  end

  def creator_email
    creator&.email
  end

  def comments
    post_comments.root_comments.order(created_at: :desc)
  end
end
