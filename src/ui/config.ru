require "rubygems"
require "bundler/setup"
Bundler.require(:default)

require "prometheus/middleware/collector"
require "prometheus/middleware/exporter"
require "./middleware"
require_relative "ui_app"

use Metrics
use Rack::Deflater, :if => ->(_, _, _, body) { body.any? && body[0].length > 512 }
use Prometheus::Middleware::Collector
use Prometheus::Middleware::Exporter

run Sinatra::Application
