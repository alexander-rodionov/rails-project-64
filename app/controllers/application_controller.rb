# frozen_string_literal: true

class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  add_flash_types :success
  rescue_from StandardError, with: :process_internal_server_error

  def render_unauthorized
    render file: 'public/401.html', status: :unauthorized
  end

  private

    def process_internal_server_error(exception)
      Rails.logger.error("Unhandled exception: #{exception.message}")
      Rails.logger.error(exception.backtrace.join("\n"))
      capture_to_sentry(exception)
      render file: Rails.public_path.join('500.html'),
             layout: false,
             status: :internal_server_error
    end

  def capture_to_sentry(exception)
    Sentry.with_scope do |scope|
      scope.set_context(
        'params',
        params.to_unsafe_h
      )
      Sentry.capture_exception(exception)
    end
    raise exception
  end
end
