
class Narrabot::The_Text_From_Each_Story
  attr_reader :the_text

  BASE_URL = "http://www.read.gov/aesop/"

  @@text_for_stories_hash = {}

  def initialize(story_selection_from_input)
    @the_text = get_story_text(story_selection_from_input)
    @@text_for_stories_hash[story_selection_from_input] = @the_text
  end

  def get_story_text(from_input) #this is a helper method
    use_this_to_index = (Narrabot::Story.table_of_contents).to_a
    scrape_text_from_here = BASE_URL + use_this_to_index[from_input].the_link #remember you're grabbing it from an object -- hence: '.the_link'
    read_this = Narrabot::Scraper.aesop_fable_text(scrape_text_from_here)
    #read_this.play ("en")
  end

  def self.text_for_stories_hash
    @@text_for_stories_hash
  end


end
