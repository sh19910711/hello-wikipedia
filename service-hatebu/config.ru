require "bundler/setup"
Bundler.require :default
require_relative "app"

Padrino.mount("App").to("/")
run Padrino.application
