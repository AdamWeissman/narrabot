require_relative "narrabot/version"
require_relative "narrabot/cli"
require_relative "narrabot/story"
require_relative "narrabot/scraper"
Dir["narrabot/frames/*.txt"].each {|file| require file }
require 'nokogiri'
require 'open-uri'
require 'tts'
require 'pry'

module Narrabot
  class Error < StandardError; end
  # Your code goes here...
end
