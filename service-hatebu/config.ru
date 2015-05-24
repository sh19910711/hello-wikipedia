require "bundler/setup"
Bundler.require :default
require_relative "app"

Mongoid::Config.sessions =
  if ENV["MONGO_URI"]
    {default: {uri: ENV["MONGO_URI"] }}
  else
    {default: {hosts: ["localhost:27017"], database: "wikipedia-to-hatebu"}}
  end

Padrino.mount("App").to("/")
run Padrino.application
