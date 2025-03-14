class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :get_current_user

  def get_current_user
    @current_user = nil#User.take
  end

  def assert_logged_in
    redirect_to login_user_path, notice: "Please log in" if @current_user.nil?
  end
end
