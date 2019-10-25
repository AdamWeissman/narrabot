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
     1) it returns the name of each constant collection (although this is just hardcoded... seems pointless to scrape ONE single 'table of contents' via code when you have to type the name of variable anyways)
     2) it scrapes the CONSTANT and returns STORY TITLES and STORY LINKS which story_collection_contents turns into an object
          NOTE: the Titles and Links will go into the appropriate object in story_collection_contents...
            the name of the collection will be hardcoded to correspond with the variable
                aesops_table_of_contents = "Aesop's Fables"
                hans_tables_of_contents = "Hans Christian Andersen Stories"
                etc...
        This method is "invoked" when a hardcored story collection is selected. (see program_diagram)
        When the story collection is selected from the first CLI screen it scrapes on demand (in real time)
        The story_collection_contents object reveals the contents (so code to reveal contents is there, but data is pushed into that object from here)
     3) it scrapes the link given (the story chosen) for text...
          IN OTHER WORDS: when a story is selected from the table of contents (which is scraped in method 2)... this method (3) scrapes on demand the text for that story
=end






  doc = Nokogiri::HTML(open(site))
  #puts doc
  story = doc.css("p")
  story.each {|sentence| puts sentence.text}
  #aesop_individual_fable_place_holder = "http://www.read.gov/aesop/002.html"
  moral_of_the_story = doc.css("blockquote")
  puts "THE MORAL OF THE STORY IS " + moral_of_the_story.text



end
