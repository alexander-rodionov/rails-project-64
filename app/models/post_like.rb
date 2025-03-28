# frozen_string_literal: true

class PostLike < ApplicationRecord
  belongs_to :post
  belongs_to :user, class_name: 'User'
end
