require "padrino"
require_relative "app"

Padrino.mount("App").to("/")
run Padrino.application
