# frozen_string_literal: true

class MonitorController < ApplicationController
  def exception_check
    raise StandardError, 'Test exception'
  end

  def sentry_check
    if Rails.application.config.enable_sentry
      Sentry.capture_exception(Exception.new('Sentry test exception'))
    end
    redirect_to '/'
  end
end
