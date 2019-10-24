class Narrabot::CLI
  def start
    puts "Hello"
  end
end

=begin

require_relative "../lib/scraper.rb"
require_relative "../lib/student.rb"
require 'nokogiri'
require 'colorize'

class CommandLineInterface
  BASE_PATH = "https://learn-co-curriculum.github.io/student-scraper-test-page/"

  def run
    make_students
    add_attributes_to_students
    display_students
  end

  def make_students
    students_array = Scraper.scrape_index_page(BASE_PATH + 'index.html')
    Student.create_from_collection(students_array)
  end

  def add_attributes_to_students
    Student.all.each do |student|
      attributes = Scraper.scrape_profile_page(BASE_PATH + student.profile_url)
      student.add_student_attributes(attributes)
    end
  end

  def display_students
    Student.all.each do |student|
      puts "#{student.name.upcase}".colorize(:blue)
      puts "  location:".colorize(:light_blue) + " #{student.location}"
      puts "  profile quote:".colorize(:light_blue) + " #{student.profile_quote}"
      puts "  bio:".colorize(:light_blue) + " #{student.bio}"
      puts "  twitter:".colorize(:light_blue) + " #{student.twitter}"
      puts "  linkedin:".colorize(:light_blue) + " #{student.linkedin}"
      puts "  github:".colorize(:light_blue) + " #{student.github}"
      puts "  blog:".colorize(:light_blue) + " #{student.blog}"
      puts "----------------------".colorize(:green)
    end
  end

end

=end


=begin

    --- The View from Management ---
  A voice actor known as Narrabotticelli changed his name to Narrabot
    because he wanted to 'cash in' on that internet gravy.
  Narrabot conceived the brilliant idea of using his voice to read stories.
    But alas.  In his Narrabot's own words:
      I'm small time.  I wanted to work with an API, but I got stuck with Nasty No.
      Nasty No is always hanging around with robots.txt and 'scraping' websites.
      Be honest, I don't wanna know how he does it.
      But, Lazy Librarian and Fabulous Fables are totally codependent on Nasty No.
      And here I am, trying to put on a children's show.
      I know I'll never be Mr. Rogers... but working with these mutants is a drag.
      Essentially it goes like this:
        We greet the user with an ascii fire place.
        We ask the user for their name.
          Meanwhile, Nasty No is scraping websites -- always last minute, (when he isn't writing demented haikus in the sand) --
          By the time the user has been dazzled by the fireplace and asked for their name...
            hopefully Nasty No is done scraping and doing whatever he does with Lazy Librarian,
            and we can then present the user with the story collections available.
          The user then selects a story collection.
            in my former opera singer's voice I say something like "Yes, USER, the name of your selection is an excellent choice"
          I then present the user with the option of choosing a story on their own.
            Or I ask if they'd like a random story...
            I also ask them to talk about some issue they're facing in life
              and then pick a random story anyways. lol
                well... if they choose 'some issue' it doesn't pick a totally random story,
                  but, it does choose from a preselected Most Popular stories...
                    and creates the illusion of being AI, in the same way that a horoscope or tarot reading seems specific
                    FINALLY...
          If the stars are aligned, Nasty No manages to get his scrape on with Fabulous Fables and the text is ready for consumption.
            Then in my operatic voice, I will cough cough ahem, and read the story out loud.
            When dealing with Aesop's Fables (as my show currently ONLY does), upon reaching the moral of the story I say:
              "YOU SEE, USERNAME, the moral of the story is... XYZ ..."
          Then we allow them to choose another story from the same collection or return to the main menu.
            At the time this program is created, we probably won't bother since there may be only one collection.
            The ascii fire place burns in the background the whole while that the story is read.
            At some point, I'd like to replace the fireplace with an ascii semblance of my face:
              where consonants iterate/map over a partially opened mouth (an oval)
              where vowels iterate/map over a fully opened mouth (a circle)
              and where spaces and punctuation iterate/map over a closed mouth (a line)
                it's essentially the sock puppet method.
          And... that is all.

=end
