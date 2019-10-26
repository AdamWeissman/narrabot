class Narrabot::CLI
  def start
    puts "Hello"
    make_stories
    list_all_stories
    choose_story(user_input)
  end

  def list_all_stories
    puts "here are all the stories, choose a number for the story you want."
    Narrabot::Story.table_of_contents.each.with_index(1) do |thing, num|
      puts "#{num} for #{thing.title}"
    end
    input = gets.chomp.to_i #YOU ARE HERE
  end

  def make_stories #calling the scraper
    Narrabot::Scraper.aesop_fable_toc_titles_and_links
    #Narrabot::Story.new("Something", "http://www.something.com")
    #Narrabot::Story.new("Something Else", "http://www.somethingelse.com")
  end

  def choose_story()

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
