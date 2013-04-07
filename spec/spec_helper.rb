$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'
$LOAD_PATH.unshift File.dirname(__FILE__)

require 'rubygems'
require 'rspec'
require 'rn'

RSpec.configure do |config|
  config.before :each do
  end

  config.after :each do
  end
end
