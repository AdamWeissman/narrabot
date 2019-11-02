class Narrabot::CLI

  def set_name
    play_and_puts("What's your name? ")
    name = gets.chomp.to_s
  end

  def start
    play_and_puts("Give me a second while I insert the activation cassette into my ear.")
    beginning_animation
    @name = set_name
    puts ""
    play_and_puts("Hi #{@name} it's a pleasure to meet you. I'm the narrabot.")
    puts ""
    play_and_puts("Please choose a story from the list.")
    make_stories
    list_all_stories
    puts ""
    #play_and_puts("Just a heads up #{@name}, in case you get clever and enter a negative number or decimal, or something crazy.  I make negatives positive, decimals I will switch; throw a random number atchya instead of a glitch.")
    main_options
    more_stories_or_exit
  end

  def play_and_puts(a_string)
    "#{a_string}".play ("en")
    print "CLOSED CAPTIONING: " + a_string + "\n"
  end

  def make_stories #calling the scraper
    Narrabot::Scraper.aesop_fable_toc_titles_and_links
  end

  def beginning_animation(frames_version = "frames")
    i = 118
    while i < 135
      print "\033[2J"
      File.open("lib/narrabot/#{frames_version}/#{i}.txt").each do |line|
        puts line
      end
      sleep(0.20)
      i += 1
    end
  end


  def ending_animation(frames_version = "frames")
    i = 134
    while i > 130
      print "\033[2J"
      File.open("lib/narrabot/#{frames_version}/#{i}.txt").each do |line|
        puts line
      end
      sleep(0.20)
      i -= 1
    end
    j = 123
    while j > 117
      print "\033[2J"
      File.open("lib/narrabot/#{frames_version}/#{j}.txt").each do |line|
        puts line
      end
      sleep(0.20)
      j -= 1
    end
    k = 131
    while k < 135
      print "\033[2J"
      File.open("lib/narrabot/#{frames_version}/#{k}.txt").each do |line|
        puts line
      end
      sleep(0.20)
      k += 1
    end

  end

  def list_all_stories
    Narrabot::Story.table_of_contents.each.with_index(1) do |thing, num|
      puts "#{num} - #{thing.title}"
    end
  end

  def main_options
    play_and_puts("\nWould you like to read the story as text, have it played as audio, or hear your fortune?")
    input = gets.chomp.to_s
    puts ""
    if input.include? "fortune"
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
    this_here = pick_a_story
    puts "\n   #{this_here.title}"
    puts "\n"
    Narrabot::Scraper.aesop_fable_text(this_here) if !this_here.text_and_moral
    puts this_here.text_and_moral
    puts "\n"
    puts "Would you like me to read this story in my beautiful voice?"
    input = gets.chomp
    switch = yes_or_no(input)
    if switch == true
      puts ""
      "#{this_here.text_and_moral}".play ("en")
    else
      puts ""
      play_and_puts("Okay")
    end
  end

  def user_choice_audio_version
    this_here = pick_a_story
    "We begin #{this_here.title.gsub(/&/, "and")}".play ("en")
    Narrabot::Scraper.aesop_fable_text(this_here) if !this_here.text_and_moral
    play_and_puts("#{this_here.text_and_moral}")
  end

  def pick_a_story #helper method for user_choice text or audio versions
    play_and_puts("Type the number of the story you would like.")
    input = gets.chomp
    puts ""
    checked_input = number_or_string(input)

    if (checked_input.is_a? Integer) && (checked_input!= 555)
      play_and_puts("Good choice #{@name}")
      chosen_story = Narrabot::Story.table_of_contents[checked_input - 1]
    elsif (checked_input.is_a? Integer) && (checked_input == 555)
      play_and_puts("Oh my stars #{@name}, you can't count!  I'll choose for you.")
      chosen_story = Narrabot::Story.table_of_contents[rand(1..145)]
    elsif (checked_input.is_a? Integer) && ((checked_input - 1) < 0)
      play_and_puts("That's a negative number!  I'll choose for you.")
      chosen_story = Narrabot::Story.table_of_contents[rand(1..145)]
    elsif input.include? "fortune"
      play_and_puts("Contacting Aesop")
      beginning_animation
      fortune_teller_mode
    else
      "Hey #{@name}. I'll choose for you instead".play ("en")
      chosen_story = Narrabot::Story.table_of_contents[rand(1..145)]
    end
  end

  def number_or_string(input) #helper for pick_a_story
    new_input = input.gsub(/[^\d]/, "")
    if new_input.empty?
      input
    else #return a valid number
      new_input.to_i.between?(1,146) ? new_input.to_i : 555
    end
  end

  def fortune_teller_mode
    fortune_story = Narrabot::Story.table_of_contents[rand(1..145)]
    Narrabot::Scraper.aesop_fable_text(fortune_story) if !fortune_story.text_and_moral
    play_and_puts("#{fortune_story.the_moral}")
    play_and_puts("Would you like the full text for this wisdom?  Don't worry.  I'll just put it on the screen.")
    input = gets.chomp
    yes_or_no(input)? (puts "#{fortune_story.text_and_moral}") : (play_and_puts("Okay"))
  end

  def yes_or_no(some_input) #helper method
      search_for_yes(some_input)
  end

  def search_for_yes(get_input) #helper for yes_or_no
    get_input.to_s.match? /yes|yep|yeah|yah|\by$|okay|ok|please|would|more|sure|why not|wonderful|awesome|great|like|maybe/i
  end

  def more_stories_or_exit
    play_and_puts("Would you like another story?")
    input = gets.chomp.to_s
    puts ""
    if yes_or_no(input)
      main_options
      more_stories_or_exit
    else
      play_and_puts("OKAY.  See you later.  But, remember #{@name}! #{Narrabot::Story.morals.sample}")
      ending_animation
    end
  end



end
