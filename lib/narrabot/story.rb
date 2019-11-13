
class Narrabot::Story
  attr_reader :title, :the_link
  attr_accessor :the_text, :the_moral, :text_and_moral, :parting_moral

  @@table_of_contents = []
  @@morals = []

  def initialize(title, link)
    @title = title
    @the_link = link
    @@table_of_contents << self
  end

  def self.table_of_contents
    @@table_of_contents
  end

  def parting_moral=(x)
    @@morals << x
  end

  def self.morals
    @@morals
  end

  def self.search_by_title
    puts "Type the title of a story"
    input = gets.chomp
    if (input == "") || (input == " ")
      puts "Try again"
      self.search_by_title
      else
      x = 0
      table_of_contents.each do |story_object|
        if story_object.title.downcase.include? (input.downcase)
          get_the_story = Narrabot::Story.table_of_contents[x]
          Narrabot::Scraper.aesop_fable_text(get_the_story)
          puts get_the_story.text_and_moral
          break
        else
          x += 1
        end
      end
    end
  end

end
