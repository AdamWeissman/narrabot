#!/usr/bin/env ruby

class Narrabot::Lazy_Librarian

end


=begin

class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    student_hash.each do |attribute, value|
      self.send("#{attribute}=", value)
    end
    @@all << self

    #   student_hash.each {|key, value| self.send(("#{key}="), value)}
    #@@all << self

  end

  def self.create_from_collection(students_array)
      students_array.each do |student_hash|
      Student.new(student_hash)
    end
  end

  def add_student_attributes(attributes_hash)
      attributes_hash.each do |attribute, value|
      self.send("#{attribute}=", value)
    end
    self
  end

  def self.all
     @@all
  end
end


=end





=begin

    --- THE LAZY LIBRARIAN SPEAKS ---
  Hi, I'm the lazy librarian.  I work for Narrabot.
  I make Lazy_Librarian objects.
  A Lazy_Librarian object is a directory of links for a collection of stories.
  A collection of stories might be:
    Aesop's Fables,
    or Hans Christian Anderson, or Brother's Grimm
    or... Bullfinch's Mythology.
    or whatever you can think of...
    But that's it.

  After Nokogiri gets the collection of stories, I organize them like this:
    Story Collection Title
      Story Title 1
        Link to Story 1
      Story Title 2
        Link to Story 2
      Story Title 3 etc...
        Link to Story 3 etc...

  But to reiterate, I don't make stories.  I don't tell stories.

  On Facebook I list my relationship with Nokogiri as "It's complicated" because...
      Nokogiri is a Ninja, Coal Miner, and Lumberjack rolled into one.
      Nokogiri means fine toothed saw in Japanese? mMmmMMm.
      But I digress.
      My relationship is complicated because (sigh):
        Nokogiri ALSO "has a relationship" with Fabulous_Fables.
        And.
        I can't even.  I just can't.

=end
