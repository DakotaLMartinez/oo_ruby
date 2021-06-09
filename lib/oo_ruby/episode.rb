# psuedocode our plan:
# 1. create a class called Episode
# 2. within the class we need to define initialize so we can pass attributes in when we create an episode.
# 3. our object has to have attributes (synonymous to instance variables) of name, season, number, airdate, summary

class Episode
  attr_accessor :name, :season, :number, :airdate, :summary
  def initialize(hash)
    @name = hash["name"]
    @season = hash["season"]
    @number = hash["number"]
    @airdate = hash["airdate"]
    @summary = hash["summary"]
    @@all << self
  end

  @@all = []

  def self.get_all
    # array of hashes
    
    result = friends["_embedded"]["episodes"].map do |episode_hash|
      # in here we need to use episode_hash to create a new episode object (instance)
      # 3 pieces: Object, method, argument
      Episode.new(episode_hash)
    end
  end

  def self.all
    @@all
  end
end

# each, map, select, find, reduce

# get_all method needs to iterate over all of the episodes (an array of hashes) and return an array of Episode objects. 
# If we assign a variable episode_data to the first hash in the array of hashes, we can work on getting the logic to work with that one element in the array. Then, we can copy that code inside of the block that we pass to map.

# You don't want to drop a pry into a loop that will run 200+ times. So, instead you declare a variable with the name as your block parameter and set it equal to one of the elements.