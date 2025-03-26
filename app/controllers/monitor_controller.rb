class MonitorController < ApplicationController
  def exception_check
    # check how prod reacts on exception
    raise Exception.new('Test exception')
    redirect_to '/'
  end

  def sentry_check
    # check how prod reacts on sentry call
    Sentry.capture_exception(Exception.new('Sentry test exception'))
    redirect_to '/'
  end
end
