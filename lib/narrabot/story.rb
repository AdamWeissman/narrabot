
class Narrabot::Story
  attr_reader :title, :the_link
  attr_accessor :the_text, :the_moral, :text_and_moral

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

  def the_moral=(x)
    @@morals << x
  end

  def self.morals
    @@morals
  end

end
