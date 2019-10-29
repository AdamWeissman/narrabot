require_relative "narrabot/version"
require_relative "narrabot/cli"
require_relative "narrabot/story"
require_relative "narrabot/scraper"
require_relative "narrabot/flair"
require 'nokogiri'
require 'open-uri'
require 'tts'
require 'pry'
require 'parallel'

module Narrabot
  class Error < StandardError; end
  # Your code goes here...
end
