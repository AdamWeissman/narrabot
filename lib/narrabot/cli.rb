class Narrabot::CLI

  attr_accessor :user_choice

  #BASE_URL = "http://www.read.gov/aesop/"

  def start
    #x = Narrabot::Flair.new
    #x.animation
    make_stories
    list_all_stories
  end

  def list_all_stories
    Narrabot::Story.table_of_contents.each.with_index(1) do |thing, num|
      puts "#{num} - #{thing.title}"
    end
    user_choice_text_version
  end

  def make_stories #calling the scraper
    Narrabot::Scraper.aesop_fable_toc_titles_and_links
  end

=begin
  def user_choice1
    "Choose the number of the story you would like to hear".play ("en")
    input = gets.chomp.to_i - 1
    Narrabot::The_Text_From_Each_Story.new(input)
    use_this_to_index = (Narrabot::Story.table_of_contents)
    "You have chosen #{use_this_to_index[input].title}".play ("en")
    Narrabot::The_Text_From_Each_Story.text_for_stories_hash[input].play ("en")
    #play_the_story(input)
  end
=end

  def user_choice_text_version
    "Choose the number of the story you would like to hear".play ("en")
    input = gets.chomp.to_i - 1
    #Narrabot::The_Text_From_Each_Story.new(input)
    use_this_to_index = (Narrabot::Story.table_of_contents)
    chosen_story = Narrabot::Story.table_of_contents[input]
    puts "You have chosen #{chosen_story.title}"
    Narrabot::Scraper.aesop_fable_text(chosen_story) if !chosen_story.the_text
    puts chosen_story.the_text
  end

end

#  def play_the_story(this_plays) #helper method for user_choice and animating method
#    on_off_animation = "off"
#    Narrabot::The_Text_From_Each_Story.text_for_stories_hash[this_plays].play ("en")
#    on_off_animation = puts "on"
#  end

#end
