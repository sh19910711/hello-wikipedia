require "bundler/setup"
Bundler.require :test, :default

Mongoid::Config.sessions = {
  default: {hosts: ["localhost:27017"],
  database: "wikipedia-to-hatebu-test"},
}

Padrino.logger.level = Logger::UNKNOWN
require_relative "../app"
