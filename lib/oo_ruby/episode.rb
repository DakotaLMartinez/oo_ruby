# attr_accessor :
# def initialize takes hash of attributes and assigns values to self
class Episode 
  attr_accessor :name, :season, :number, :summary, :airdate
  # friends["_embedded"]["episodes"].first.keys.map(&:to_sym).each{|sym| attr_accessor sym}
  def initialize(attributes)
    # puts attributes
    # @name = attributes["name"]
    # @season = attributes["season"]
    # @number = attributes["number"]
    # @summary = attributes["summary"]
    # @airdate = attributes["airdate"]
    attributes.each do |attribute, value|
      self.send("#{attribute}=", value) if self.respond_to?("#{attribute}=")
    end
    @@all << self
  end

  @@all = []

  def self.all
    @@all = friends["_embedded"]["episodes"].map do |episode_hash|
      self.new(episode_hash)
    end
  end
end