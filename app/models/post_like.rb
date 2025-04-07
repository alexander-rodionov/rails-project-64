# frozen_string_literal: true

class PostLike < ApplicationRecord
  belongs_to :post, counter_cache: true
  belongs_to :user, class_name: 'User'
end
