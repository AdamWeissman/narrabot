class Narrabot::CLI

  def set_name
    puts "\nWhat's your name? "
    name = gets.chomp.to_s
  end

  def start
    @name = set_name
    make_stories
    list_all_stories
    audio_or_text
    more_stories_or_exit
  end

  def make_stories #calling the scraper
    Narrabot::Scraper.aesop_fable_toc_titles_and_links
  end

  def list_all_stories
    Narrabot::Story.table_of_contents.each.with_index(1) do |thing, num|
      puts "#{num} - #{thing.title}"
    end
  end

  def audio_or_text
    puts "\nWould you like to read the story as text, or have it played as audio?"
    input = gets.chomp.to_s
    input.match? /sound|play|audio|speak|speech|talk|loud|hear/i ? switch = "on" : switch = "off"
    if switch == "on"
      user_choice_audio_version
    else
      user_choice_text_version
    end
  end

  def user_choice_text_version
    puts "\nChoose the number of the story you want to read: "
    this_here = pick_a_story
    puts "\nYou have chosen #{this_here.title}"
    Narrabot::Scraper.aesop_fable_text(this_here) if !this_here.text_and_moral
    puts this_here.text_and_moral
  end

  def user_choice_audio_version
    #"put your text to play here".play ("en")
    # Supported languages: ["zh", "en", "it", "fr"]
    "Choose the number of the story you would like to hear".play ("en")
    this_here = pick_a_story
    "You have chosen #{this_here.title.gsub(/&/, "and")}".play ("en")
    Narrabot::Scraper.aesop_fable_text(this_here) if !this_here.text_and_moral
    "#{this_here.the_text}".play ("en")
    "#{this_here.the_moral}".play ("en")
  end

  def pick_a_story #helper method for user_choice text or audio versions
    input = gets.chomp.to_i - 1
    if input.between?(0,145)
      use_this_to_index = (Narrabot::Story.table_of_contents)
      chosen_story = Narrabot::Story.table_of_contents[input]
    else
      "Sorry, that's not on the list. Try again.".play ("en")
      pick_a_story
    end
  end

  def more_stories_or_exit
    puts "\nWould you like another story?"
    input = gets.chomp.to_s
    input.match? /yes|yep|yeah|yah|\by|please|would|more/i ? switch = "on" : switch = "off"
    if switch == "on"
      audio_or_text
      more_stories_or_exit
    else
      "Remember #{@name}! #{Narrabot::Story.morals.sample}".play ("en")
    end
  end



end
