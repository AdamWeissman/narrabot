#!/usr/bin/env ruby

class Narrabot::Scraper

  require 'nokogiri'
  require 'open-uri'

  AESOP_FABLES = "http://www.read.gov/aesop/001.html"
  HAN_CHRISTIAN_ANDERSEN = "http://www.gutenberg.org/files/27200/27200-h/27200-h.htm"
  BROTHERS_GRIMM = "https://www.gutenberg.org/files/2591/2591-h/2591-h.htm"
  JAPANESE_FOLKTALES = "http://www.gutenberg.org/files/35853/35853-h/35853-h.htm"
  ZEN_KOANS_SHASEKI_SHU = "http://www.ashidakim.com/zenkoans/zenindex.html"

  #How does the scraper work?
  #  each collection will have three "in real time" methods.
=begin
     1) it returns the name of each constant collection (although maybe this is just hardcoded?)
     2) it scrapes the CONSTANT and returns STORY TITLES and STORY LINKS which story_collection_contents turns into an object
          NOTE: the story_collection_contents also has a "blank" space to be populated by the second method...
          ANOTHER NOTE: it only performs this 2nd method if the collection is selected
     3) it scrapes the link given (the story chosen) for text...
          IN OTHER WORDS:
=end






  doc = Nokogiri::HTML(open(site))
  #puts doc
  story = doc.css("p")
  story.each {|sentence| puts sentence.text}
  #aesop_individual_fable_place_holder = "http://www.read.gov/aesop/002.html"
  moral_of_the_story = doc.css("blockquote")
  puts "THE MORAL OF THE STORY IS " + moral_of_the_story.text



end
