require "bundler/setup"
Bundler.require :test, :default

Padrino.logger.level = Logger::UNKNOWN
require_relative "../app"
