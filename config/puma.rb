# frozen_string_literal: true

threads_count = ENV.fetch('RAILS_MAX_THREADS', 3)
threads threads_count, threads_count

bind "tcp://0.0.0.0:#{ENV.fetch('PORT', 3000)}"

plugin :tmp_restart

pidfile ENV['PIDFILE'] if ENV['PIDFILE']
