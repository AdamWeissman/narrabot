module Narrabot::HelperElves

  def play_and_puts(a_string)
    too_long_to_be_trapped_in_audio = a_string.split
    if too_long_to_be_trapped_in_audio.count >= 26 #words
      break_up_the_text = a_string.split("\n")
      "Heads up! This story is #{too_long_to_be_trapped_in_audio.count.to_s} words long. You'll be prompted if a passage is more than 25 words.".play ("en")
      print "CLOSED CAPTIONING: " + "This story is #{too_long_to_be_trapped_in_audio.count.to_s} words long. You'll be prompted if a passage is more than 25 words." + "\n"
      break_up_the_text.each do |section|

        if section.split.count <= 25
          "#{section}".play ("en")
          print "CLOSED CAPTIONING: " + section + "\n"
        else
          puts "\n"
          puts "...may I go on? "
          input = gets.chomp
          if yes_or_no(input) || (input == "") || (input == " ") || (input == "  ")
            puts ""
            "#{section}".play ("en")
            print "CLOSED CAPTIONING: " + section + "\n"
          else
            break
          end
        end

      end
    else
      "#{a_string}".play ("en")
      print "CLOSED CAPTIONING: " + a_string + "\n"
  end

=begin
  THIS IS THE OLD METHOD
  "#{a_string}".play ("en")
  print "CLOSED CAPTIONING: " + a_string + "\n"
=end

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

  def fortune_animation(frames_version = "psychic_frames")
    2.times do
      i = 100
      while i < 116
        print "\033[2J"
        File.open("lib/narrabot/#{frames_version}/#{i}.txt").each do |line|
          puts line
        end
        sleep(0.15)
        i += 1
      end
    end
  end

    #USERCHOICES: TEXT, AUDIO, PICK, FORTUNE

    def user_choice_text_version
      this_here = pick_a_story
      puts "\n   #{this_here.title}"
      puts "\n"
      Narrabot::Scraper.aesop_fable_text(this_here) if !this_here.text_and_moral
      puts this_here.text_and_moral
      puts "\n"
      #puts "Would you like me to read this story in my beautiful voice?"
      #input = gets.chomp
      #switch = yes_or_no(input)
      #if switch == true
      #  puts ""
      #  "#{this_here.text_and_moral}".play ("en")
      #else
      #  puts ""
      #  play_and_puts("Okay")
      #end
    end

    def user_choice_audio_version
      this_here = pick_a_story
      "We begin #{this_here.title.gsub(/&/, "and")}".play ("en")
      Narrabot::Scraper.aesop_fable_text(this_here) if !this_here.text_and_moral
      play_and_puts("#{this_here.the_text}")
      play_and_puts("The moral of the story is #{this_here.the_moral}")
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
      elsif input.downcase.include? "fortune"
        fortune_teller_mode
      else
        "Okay #{@name}. I'll choose".play ("en")
        chosen_story = Narrabot::Story.table_of_contents[rand(1..145)]
      end
    end

    def fortune_teller_mode
      play_and_puts("Checking my crystal ball...")
      fortune_animation
      fortune_story = Narrabot::Story.table_of_contents[rand(1..145)]
      Narrabot::Scraper.aesop_fable_text(fortune_story) if !fortune_story.text_and_moral
      play_and_puts("#{fortune_story.the_moral}")
      play_and_puts("Would you like the full text for this wisdom?  Don't worry.  I'll just put it on the screen.")
      input = gets.chomp
      yes_or_no(input)? (puts "#{fortune_story.text_and_moral}") : (play_and_puts("Okay"))
    end

    #HELPER METHODS FOR THE HELPERS...

    def number_or_string(input) #helper for pick_a_story
      new_input = input.gsub(/[^\d]/, "")
      if new_input.empty?
        input
      else #return a valid number
        new_input.to_i.between?(1,146) ? new_input.to_i : 555
      end
    end

    def yes_or_no(some_input) #helper method -- only returns true for yes, otherwise defaults false (no)
        search_for_yes(some_input)
    end

    def search_for_yes(get_input) #helper for yes_or_no
      get_input.to_s.match? /yes|yep|yeah|yah|\by$|okay|ok|fine|of course|please|would|more|sure|why not|wonderful|awesome|great|maybe yes|alright|like/i
    end



end
