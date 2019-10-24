#!/usr/bin/env ruby

#require_relative '../lib/environment'

require 'tts'
# Will download "Hello World!.mp3" to your current directory
# Supported languages: ["zh", "en", "it", "fr"]
"Hello I am the narrabot!".play ("it")

Narrabot::CLI.new.start  #THIS IS HOW TO START THE PROGRAM
=begin
require 'nokogiri'
require 'open-uri'
#site = "http://www.read.gov/aesop/001.html"
site = "http://www.read.gov/aesop/002.html"
doc = Nokogiri::HTML(open(site))
#puts doc
story = doc.css("p")
story.each {|sentence| puts sentence.text}

moral_of_the_story = doc.css("blockquote")
puts "THE MORAL OF THE STORY IS " + moral_of_the_story.text
#puts items.count
=end
