# frozen_string_literal: true

class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  add_flash_types :success

  rescue_from StandardError, with: :capture_to_sentry

  def render_unauthorized
    render file: 'public/401.html', status: :unauthorized
  end

  private

  def capture_to_sentry(exception)
    Sentry.with_scope do |scope|
      # Add request params (filter sensitive data first)
      scope.set_context(
        'params',
        params.to_unsafe_h
      )
      Sentry.capture_exception(exception)
    end
    raise exception
  end
end
