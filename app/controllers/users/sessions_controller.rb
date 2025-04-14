# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :html, :json

  def create
    super do |user|
      render json: { user: user.as_json(only: %i[id email]) } and return if request.format.json?

      redirect_to root_path and return
    end
  end
end
