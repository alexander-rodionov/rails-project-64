# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  respond_to :html, :json

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  def create
    super do |user|
      if request.format.json?
        render json: { user: user.as_json(only: [ :id, :email ]) } and return
      else
        redirect_to root_path and return
      end
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   #devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
