class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  add_flash_types :success
end
