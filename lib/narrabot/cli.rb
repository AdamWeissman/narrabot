class Narrabot::CLI

  attr_accessor :user_choice

  #BASE_URL = "http://www.read.gov/aesop/"

  def start
    make_stories
    list_all_stories
  end

  def list_all_stories
    Narrabot::Story.table_of_contents.each.with_index(1) do |thing, num|
      puts "#{num} - #{thing.title}"
    end
    user_choice
  end

  def make_stories #calling the scraper
    Narrabot::Scraper.aesop_fable_toc_titles_and_links
  end

  def user_choice
    "Choose the number of the story you would like to hear".play ("en")
    input = gets.chomp.to_i - 1
    Narrabot::The_Text_From_Each_Story.new(input)
    use_this_to_index = (Narrabot::Story.table_of_contents).to_a
    "You have chosen #{use_this_to_index[input].title}".play ("en")
    Narrabot::The_Text_From_Each_Story.text_for_stories_hash[input].play ("en")
  end

#  def get_story_text(from_input)
#    use_this_to_index = (Narrabot::Story.table_of_contents).to_a
#    scrape_text_from_here = BASE_URL + use_this_to_index[from_input - 1].the_link
#    read_this = Narrabot::Scraper.aesop_fable_text(scrape_text_from_here)
#    read_this.play ("en")
#  end

end
