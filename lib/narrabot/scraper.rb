#!/usr/bin/env ruby

class Narrabot::Scraper

  require 'nokogiri'
  require 'open-uri'

  AESOP_FABLES = "http://www.read.gov/aesop/001.html"
  HAN_CHRISTIAN_ANDERSEN = "http://www.gutenberg.org/files/27200/27200-h/27200-h.htm"
  BROTHERS_GRIMM = "https://www.gutenberg.org/files/2591/2591-h/2591-h.htm"
  JAPANESE_FOLKTALES = "http://www.gutenberg.org/files/35853/35853-h/35853-h.htm"
  ZEN_KOANS_SHASEKI_SHU = "http://www.ashidakim.com/zenkoans/zenindex.html"

  #How does the scraper work? SEE BOTTOM OF THIS FILE to avoid top heavy clutter!

  #SCRAPING AESOP...
  #aesop_site_contents = "http://www.read.gov/aesop/001.html" #UNSCRAPED (substitute with constant later)

  #TABLE OF CONTENTS, TITLES AND LINKS...
  def aesop_fable_toc_titles_and_links(aesop_site_contents = AESOP_FABLES) #NOTE: All individual code works here, tried on REPL, but have not tried as a method yet.
    aesop_everything = Nokogiri::HTML(open(aesop_site_contents)) #SCRAPED
    aesop_table_of_contents_titles = aesop_everything.css("div#toc li a").to_a #CONVERT TO AN ARRAY (unformatted as text)
    aesop_table_of_contents_titles.map! {|title| title.text} #CONVERT TITLE TEXT ONLY
    aesop_table_of_contents_links = aesop_everything.css("div#toc li a").to_a #CANNOT USE ABOVE ARRAY BECAUSE OF MAP IN PLACE(!)
    aesop_table_of_contents_links.map! {|link| "http://www.read.gov/aesop/" + link['href']} #GRAAAAB THOSE LINKS

    aesop_table_of_contents_titles.zip(aesop_table_of_contents_links)
  end

  #TEXT FOR EACH STORY
  def aesop_fable_text(get_it_from_this_link_here)
    a_single_fable_by_aesop = Nokogiri::HTML(open(get_it_from_this_link_here))
    sentence_by_sentence = a_single_fable_by_aesop.css("p")
    collect_em_all = sentence_by_sentence.each {|sentence| sentence.text}
    formatting_text_step_1 = collect_em_all.to_s.gsub(/\<\/p\>/, "\n" )
    formatted_text = formatting_text_step_1.gsub!(/\<p\>/, "   " )

    formatted_text + "\n" + aesop_moral_of_the_story(a_single_fable_by_aesop).to_s
  end

  def aesop_moral_of_the_story(waiting_for_a_fable_from_aesop_fable_text) #this is a helper method for aesop_fable_text
    moral_of_the_story = waiting_for_a_fable_from_aesop_fable_text.css("blockquote")
    the_moral_is = "   The moral of the story is \"#{moral_of_the_story.text}\""
    #"THE MORAL OF THE STORY IS " + moral_of_the_story.text
  end

  puts aesop_fable_text("http://www.read.gov/aesop/002.html") #<=this tests the function

  aesop_fable_text("http://www.read.gov/aesop/002.html")


  #SCRAPING HANS CHRISTIAN ANDERSEN...
  #hca_site_contents = "http://www.gutenberg.org/files/27200/27200-h/27200-h.htm"

  #TABLE OF CONTENTS, TITLES AND LINKS...
  def hca_toc_titles_and_links(hca_site_contents = HAN_CHRISTIAN_ANDERSEN)
    hca_everything = Nokogiri::HTML(open(hca_site_contents)) #SCRAPED
    #puts hca_everything #(this right here wouldn't be part of actual program)
    hca_table_of_contents_titles = hca_everything.css("h4 a").to_a #CONVERT TO AN ARRAY (unformatted as text)
    #puts hca_table_of_contents_titles #(this right here wouldn't be part of actual program)
    hca_table_of_contents_titles.map! {|title| title.text} #CONVERT TITLE TEXT ONLY
    hca_table_of_contents_links = hca_everything.css("h4 a").to_a #CANNOT USE OTHER ARRAY BECAUSE OF MAP IN PLACE(!)
    hca_table_of_contents_links.map! {|link| hca_site_contents + link['href']} #GRAB THOSE LINKS

    hca_table_of_contents_titles.zip(hca_table_of_contents_links)
  end

  #TEXT FOR EACH STORY






  #THIS IS FOR BROTHER'S GRIMM
  bgrimm_site_contents = "https://www.gutenberg.org/files/2591/2591-h/2591-h.htm"
    #TABLE OF CONTENTS, TITLES AND LINKS...

    #TEXT FOR EACH STORY

  #THIS IS FOR JAPANESE FOLKTALES
  jfolktales_site_contents = "http://www.gutenberg.org/files/35853/35853-h/35853-h.htm"
    #TABLE OF CONTENTS, TITLES AND LINKS...

    #TEXT FOR EACH STORY

  #THIS IS FOR ZEN KOANS (SHASEKI-SHU)
  zen_koans_site_contents = "http://www.ashidakim.com/zenkoans/zenindex.html"
    #TABLE OF CONTENTS, TITLES AND LINKS...

    #TEXT FOR EACH STORY

  #

  #How does the scraper work? SEE BOTTOM OF THIS FILE to avoid top heavy clutter!
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




  #site = "http://www.read.gov/aesop/001.html"
  #site = "http://www.read.gov/aesop/002.html"\
  #site = "http://www.gutenberg.org/files/27200/27200-h/27200-h.htm"
  #doc = Nokogiri::HTML(open(site))
  #puts doc
  #items = doc.css("p")
  #puts items.count

  #story_title = puts doc.css("div#toc li a").text

  #story_links = doc.css("a").select{|x| x}
  #story_links.each{|z| puts z['href'] }

  #story_links.each{|z| puts z.text }


  #story_and_link = story_title.zip(story_links)




   # WATCH THIS:
  # https://www.youtube.com/watch?v=KwBMwZ89Hj8&list=PLc6AmvC5Zybybc-NjUUwQwTtUEXH4iB2s&index=2&t=0s

  #https://guides.rubygems.org/make-your-own-gem/ and then check out publish your own gem

  #ascii animation
  #https://medium.com/@killebrew.biz/animate-terminal-with-ruby-8d800a40c637

  #https://media.giphy.com/media/Arxo26T2VGbW8/giphy.gif

  #https://sammysteiner.github.io/blog/2017/04/13/bringing-terminal-applications-to-life-cli-animations-with-ruby/











end
