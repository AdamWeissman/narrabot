class Narrabot::CLI

  include Narrabot::HelperElves

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
    play_and_puts("These are the stories I have. You can enjoy them and more at read.gov.")
    make_stories
    list_all_stories
    puts ""
    play_and_puts("Just a heads up #{@name}, in case you get clever and enter a negative number or decimal, or something crazy.  I make negatives positive, decimals I will switch; throw a random number atchya instead of a glitch.")
    main_options
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
