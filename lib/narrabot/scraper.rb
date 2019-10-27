class Narrabot::Scraper

  AESOP_FABLES = "http://www.read.gov/aesop/001.html"
  #HAN_CHRISTIAN_ANDERSEN = "http://www.gutenberg.org/files/27200/27200-h/27200-h.htm"
  #BROTHERS_GRIMM = "https://www.gutenberg.org/files/2591/2591-h/2591-h.htm"
  #JAPANESE_FOLKTALES = "http://www.gutenberg.org/files/35853/35853-h/35853-h.htm"
  #ZEN_KOANS_SHASEKI_SHU = "http://www.ashidakim.com/zenkoans/zenindex.html"

  #How does the scraper work? SEE BOTTOM OF THIS FILE to avoid top heavy clutter!

  #SCRAPING AESOP...
  #aesop_site_contents = "http://www.read.gov/aesop/001.html" #UNSCRAPED (substitute with constant later)

  #TABLE OF CONTENTS, TITLES AND LINKS...
  def self.aesop_fable_toc_titles_and_links(aesop_site_contents = AESOP_FABLES) #NOTE: All individual code works here, tried on REPL, but have not tried as a method yet.
    aesop_everything = Nokogiri::HTML(open(aesop_site_contents)) #SCRAPED
    aesop_table_of_contents_titles = aesop_everything.css("div#toc li a")
    aesop_table_of_contents_titles.each do |thing|
      the_link = thing.attr("href")
      the_title = thing.text
      Narrabot::Story.new(the_title, the_link)
    end
  end

  #TEXT FOR EACH STORY
  def self.aesop_fable_text(get_it_from_this_link_here)
    a_single_fable_by_aesop = Nokogiri::HTML(open(get_it_from_this_link_here))
    sentence_by_sentence = a_single_fable_by_aesop.css("p")
    collect_em_all = sentence_by_sentence.each {|sentence| sentence.text}
    formatting_text_step_1 = collect_em_all.to_s.gsub(/\<\/p\>/, "\n" )
    formatted_text = formatting_text_step_1.gsub!(/\<p\>/, "   " )

    formatted_text + "\n" + aesop_moral_of_the_story(a_single_fable_by_aesop).to_s
  end

  def self.aesop_moral_of_the_story(waiting_for_a_fable_from_aesop_fable_text) #this is a helper method for aesop_fable_text
    moral_of_the_story = waiting_for_a_fable_from_aesop_fable_text.css("blockquote")
    the_moral_is = "   The moral of the story is \"#{moral_of_the_story.text}\""
    #"THE MORAL OF THE STORY IS " + moral_of_the_story.text
  end

  #puts aesop_fable_text("http://www.read.gov/aesop/002.html") #<=this tests the function

  #aesop_fable_text("http://www.read.gov/aesop/002.html")


  #SCRAPING HANS CHRISTIAN ANDERSEN...
  #hca_site_contents = "http://www.gutenberg.org/files/27200/27200-h/27200-h.htm"

  #TABLE OF CONTENTS, TITLES AND LINKS...
  #def hca_toc_titles_and_links(hca_site_contents = HAN_CHRISTIAN_ANDERSEN)
  #  hca_everything = Nokogiri::HTML(open(hca_site_contents)) #SCRAPED
    #puts hca_everything #(this right here wouldn't be part of actual program)
#    hca_table_of_contents_titles = hca_everything.css("h4 a").to_a #CONVERT TO AN ARRAY (unformatted as text)
    #puts hca_table_of_contents_titles #(this right here wouldn't be part of actual program)
#    hca_table_of_contents_titles.map! {|title| title.text} #CONVERT TITLE TEXT ONLY
#    hca_table_of_contents_links = hca_everything.css("h4 a").to_a #CANNOT USE OTHER ARRAY BECAUSE OF MAP IN PLACE(!)
#    hca_table_of_contents_links.map! {|link| hca_site_contents + link['href']} #GRAB THOSE LINKS

  #  hca_table_of_contents_titles.zip(hca_table_of_contents_links)
  #end



end
