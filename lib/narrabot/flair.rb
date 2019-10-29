#this is to record the animated ascii fireplace that will loop while stories are read by tts
#will probably need a folder to store the files
#note, check out Sammy Steiner's project blog (and giphy and the thing from medium)
#ascii animation
#https://medium.com/@killebrew.biz/animate-terminal-with-ruby-8d800a40c637

#https://media.giphy.com/media/Arxo26T2VGbW8/giphy.gif

#https://sammysteiner.github.io/blog/2017/04/13/bringing-terminal-applications-to-life-cli-animations-with-ruby/


class Narrabot::Flair

  def animation_during(this_here, only_if_on)
      #if ON_BUTTON_SET_
      i = 1
      while i < 3
        print "\033[2J"
        File.foreach("lib/narrabot/flair_folder/#{i}.txt") { |f| puts f }
        sleep(0.03)
        i += 1
      end
  end

end


# pseudocode mock up of how animation in parallel might work...
# make this: Narrabot::The_Text_From_Each_Story.text_for_stories_hash[input].play ("en")
#   into its own function with an additional line of code that sets some variable to waiting_for_a_fable_from_aesop_fable_text
# the OFF variable
