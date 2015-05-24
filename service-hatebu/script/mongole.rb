require "bundler/setup"
Bundler.require :default, :development

Mongoid::Config.sessions =
  if ENV["MONGO_URI"]
    {default: {uri: ENV["MONGO_URI"] }}
  else
    {default: {hosts: ["localhost:27017"], database: "wikipedia-to-hatebu"}}
  end

require_relative "../models/pagerank"

byebug
exit

