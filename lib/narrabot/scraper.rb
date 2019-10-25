#!/usr/bin/env ruby

class Narrabot::Scraper

  require 'nokogiri'
  require 'open-uri'

  AESOP_STORY_COLLECTION = "http://www.read.gov/aesop/001.html"




WHAT AM I DOING?
  I am scraping the story collection
  To get a list of a fables that (the Lazy_Librarian) will then use to create the general index of stories
  with the titles of the stories and also the links

WHAT I WILL DO NEXT...
  I will then use the link variables from lazy_librarian to pass to the secondary scraper here
  in order to...
    scrape individual stories (when people select those stories from lazy librarian's collection)



  doc = Nokogiri::HTML(open(site))
  #puts doc
  story = doc.css("p")
  story.each {|sentence| puts sentence.text}
  #aesop_individual_fable_place_holder = "http://www.read.gov/aesop/002.html"
  moral_of_the_story = doc.css("blockquote")
  puts "THE MORAL OF THE STORY IS " + moral_of_the_story.text



end
