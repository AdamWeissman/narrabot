
class Narrabot::Story
  attr_reader :title, :the_link
  attr_accessor :the_text

  @@table_of_contents = []

  def initialize(title, link)
    @title = title
    @the_link = link
    @@table_of_contents << self
  end

  def self.table_of_contents
    @@table_of_contents
  end

end
