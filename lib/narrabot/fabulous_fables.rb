#!/usr/bin/env ruby

class Narrabot::Fabulous_Fables

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

    --- FABULOUS FABLES TELLS ALL ---

  HALLO, HOLA, ALOHA, and KONICHIWA!!!  I'm Fabulous Fables.
  I work for Narrabot and Lazy Librarian.
    You'd think:
    if Lazy Librarian was gonna go through all the trouble of making
      Lazy Librarian Objects, then...
    she'd at least go through the trouble of grabbing the text for each story.
      Right?
    SMH.  She can't handle it.
    And then she blames ME for spending too much time with Nokogiri.
    But, if she wants to blame anyone:
      she oughta look in the mirror first.
    That and... not to brag, but I'm kind of a big deal.
    No one splits text like me.
    ::SNAPS FINGERS::

=end
