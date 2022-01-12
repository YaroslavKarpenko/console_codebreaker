require 'simplecov'
SimpleCov.start do
  minimum_coverage 95
  add_filter 'spec'
  add_filter 'vendor'
end

require 'bundler/setup'
require 'codebreaker'
require 'ffaker'

require_relative 'spec_loader'
