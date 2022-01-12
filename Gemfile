# frozen_string_literal: true

source 'https://rubygems.org'

gem 'codebreaker', git: 'https://github.com/YaroslavKarpenko/gem_codebreaker.git', branch: 'develop'
gem 'i18n', '~> 1.8.10'
gem 'pry', '~> 0.14.1'
gem 'rake', '~> 13.0'
gem 'terminal-table', '~>3.0.0'

group :development do
  gem 'fasterer', '~> 0.8.3'
  gem 'lefthook', '~> 0.7.7'

  gem 'rubocop', '~> 1.22.1'
  gem 'rubocop-performance', '~> 1.11.5', require: false
end

group :test do
  gem 'rspec', '~> 3.0'
  gem 'rspec_junit_formatter', '~> 0.4.1'
  gem 'rubocop-rspec', '~> 2.5.0'
  gem 'simplecov', '~> 0.21.2'
end

group :development, :test do
  gem 'ffaker', '~> 2.20.0'
end
