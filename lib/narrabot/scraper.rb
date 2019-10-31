class Narrabot::Scraper

  AESOP_FABLES = "http://www.read.gov/aesop/001.html"
  BASE_URL = "http://www.read.gov/aesop/"

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
  def self.aesop_fable_text(story_object)
    a_single_fable_by_aesop = Nokogiri::HTML(open(BASE_URL + story_object.the_link))
    sentence_by_sentence = a_single_fable_by_aesop.css("p")
    collect_em_all = sentence_by_sentence.each {|sentence| sentence.text}
    formatting_text_step_1 = collect_em_all.to_s.gsub(/\<\/p\>/, "\n" )
    formatted_text = formatting_text_step_1.gsub!(/\<p\>/, "   " )

    the_moral_is = aesop_moral_of_the_story(a_single_fable_by_aesop).to_s

    the_whole_story = formatted_text + "\n" + "   " + the_moral_is

    story_object.text_and_moral = the_whole_story
    story_object.the_text = formatted_text
    story_object.the_moral = the_moral_is
  end

  def self.aesop_moral_of_the_story(waiting_for_a_fable_from_aesop_fable_text) #this is a helper method for aesop_fable_text
    moral_of_the_story = waiting_for_a_fable_from_aesop_fable_text.css("blockquote")
    the_moral_is = "The moral of the story is \"#{moral_of_the_story.text}\""
  end

end
