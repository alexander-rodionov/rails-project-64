# frozen_string_literal: true

class MonitorController < ApplicationController
  def exception_check
    raise StandardError, 'Test exception'
    redirect_to '/'
  end

  def sentry_check
    Sentry.capture_exception(Exception.new('Sentry test exception'))
    redirect_to '/'
  end
end
