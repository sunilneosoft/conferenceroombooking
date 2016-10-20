ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' # Set up gems listed in the Gemfile.

ALLOTED = "ALLOTED"
WAITING = "WAITING"
FREE = "FREE"
CANCEL = "CANCEL"