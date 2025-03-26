
Sentry.init do |config|
  config.dsn = ENV["SENTRY_DSN"] || "https://a4f72f0bebde422ca8aaeea8daacf6b7@app.glitchtip.com/10780"
  config.traces_sample_rate = 1
end
