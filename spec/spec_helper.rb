require "rubygems"
require "bundler"

Bundler.require :default

require './runners/user'
require 'simplecov'

SimpleCov.start
RSpec.configure do |config|
  config.before(:all) do
    $storage = {}
  end
end
