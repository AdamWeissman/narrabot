class Narrabot::CLI

  def set_name
    puts "\nWhat's your name? "
    name = gets.chomp.to_s
  end

  def start
    @name = set_name
    "#{@name} it's a pleasure to meet you.  I'm the Narrabot.".play ("en")
    puts "\n"
    "Please choose a story from below.".play ("en")
    make_stories
    list_all_stories
    audio_or_text_or_fortune
    #user_choice_audio_version
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

  def audio_or_text_or_fortune
    puts "\nWould you like to read the story as text, or have it played as audio?"
    input = gets.chomp.to_s
    if input.include? "tell me my fortune"
      fortune_teller_mode
    else
      input.match? $_=~/sound|play|audio|speak|speech|talk|loud|hear/i ? switch = "on" : switch = "off"
        if switch == "on"
          user_choice_audio_version
        else
          user_choice_text_version
        end
    end
  end

  def user_choice_text_version
    puts "\nChoose the number of the story you want to read: "
    this_here = pick_a_story
    puts "\n   #{this_here.title}"
    puts "\n"
    Narrabot::Scraper.aesop_fable_text(this_here) if !this_here.text_and_moral
    puts this_here.text_and_moral
    puts "\n"
    puts "Would you like me to read this story in my beautiful voice?"
    switch = yes_or_no
    if switch == true
      "#{this_here.text_and_moral}".play ("en")
    else
      "Okay"
    end
  end

  def user_choice_audio_version
    #"put your text to play here".play ("en")
    # Supported languages: ["zh", "en", "it", "fr"]no
    #"Choose the number of the story you would like to hear".play ("en")
    this_here = pick_a_story
    "We begin #{this_here.title.gsub(/&/, "and")}".play ("en")
    Narrabot::Scraper.aesop_fable_text(this_here) if !this_here.text_and_moral
    "#{this_here.text_and_moral}".play ("en")
  end

  def pick_a_story #helper method for user_choice text or audio versions
    puts ".........type the number of the story you want,\n.........or type 'tell me my fortune'."
    input = gets.chomp
    checked_input = number_or_string(input)

    if (checked_input.is_a? Integer) && (checked_input!= 555)
      chosen_story = Narrabot::Story.table_of_contents[checked_input]
    elsif (checked_input.is_a? Integer) && (checked_input == 555)
      "Oh my stars #{@name}, you can't count!  I'll choose for you.".play ("en")
      chosen_story = Narrabot::Story.table_of_contents[rand(1..145)]
    elsif input.include? "tell me my fortune"
      fortune_teller_mode
      pick_a_story
    else
      "#{@name}?  Yeah.  You know what?  How about I just choose for you?".play ("en")
      chosen_story = Narrabot::Story.table_of_contents[rand(1..145)]
    end
  end

  def number_or_string(input) #helper for pick_a_story
    new_input = input.gsub(/[^\d]/, "")
    if new_input.empty?
      input
    else #return a valid number
      new_input.to_i.between?(0,145)? new_input.to_i : 555
      #let the user know it's choosing for you via puts
    end
  end

  def fortune_teller_mode
    fortune_story = Narrabot::Story.table_of_contents[rand(1..145)]
    Narrabot::Scraper.aesop_fable_text(fortune_story) if !fortune_story.text_and_moral
    "#{fortune_story.the_moral}".play ("en")
    "Would you like the full text for this wisdom?  Don't worry.  I'll just put it on the screen.".play ("en")
    switch = yes_or_no
    if switch == true
      puts "#{fortune_story.text_and_moral}"
    else
      "Okay"
    end
    #ternary refactor
  end

  def yes_or_no #helper method
    input = gets.chomp.to_s
    input.match? $_=~/yes|yep|yeah|yah|\by|okay|please|would|more|sure|why not|wonderful|awesome|great|like|maybe/i ? switch = "on" : switch = "off"
    #115 is duped, and check out Thor
    switch == "on"
  end

  def more_stories_or_exit
    "Would you like another story?".play ("en")
    input = gets.chomp.to_s
    input.match? $_=~/yes|yep|yeah|yah|\by|oky|please|would|more|sure|why not|wonderful|awesome|great|like|maybe/i ? switch = "on" : switch = "off"
    if switch == "on"
      audio_or_text_or_fortune
      #user_choice_audio_version
      more_stories_or_exit
    else
      "OKAY.  See you later.  But, remember #{@name}! #{Narrabot::Story.morals.sample}".play ("en")
      puts "Bye."
    end
  end

end
