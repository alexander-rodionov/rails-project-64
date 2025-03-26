class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  add_flash_types :success

  rescue_from StandardError, with: :capture_to_sentry
  before_action :log_request_to_sentry

  private

  def capture_to_sentry(exception)
    Sentry.with_scope do |scope|
      # Add request params (filter sensitive data first)
      scope.set_context(
        "params",
        params.to_unsafe_h
      
      # Add current user context
      scope.set_user(id: current_user&.id, email: current_user&.email)
      
      Sentry.capture_exception(exception)
    end
    raise exception # Re-raise if you want normal error handling
  end

  def log_request_to_sentry
    Sentry.configure_scope do |scope|
      scope.set_context("request", {
        method: request.method,
        path: request.path,
        params: params.to_unsafe_h,
        headers: request.headers.to_h.select { |k| k.match(/^HTTP_/) }
      })
      scope.set_transaction_name("#{controller_name}##{action_name}")
    end
    Sentry.capture_message("Request: #{request.method} #{request.path}", level: :info)
  end

end
