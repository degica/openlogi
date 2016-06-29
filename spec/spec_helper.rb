$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'openlogi'
require "webmock/rspec"
require "pry"

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
end
