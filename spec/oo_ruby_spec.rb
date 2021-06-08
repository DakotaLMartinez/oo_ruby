RSpec.describe Episode do
  it "is a class" do
    expect(Episode).to be_a Class
  end

  it "can be initialized with a hash of attributes" do 
    episode_data = {  "id" => 40877,
                      "url" => "https://www.tvmaze.com/episodes/40877/friends-10x14-the-one-with-princess-consuela",
                      "name" => "The One With Princess Consuela",
                      "season" => 10,
                      "number" => 14,
                      "type" => "regular",
                      "airdate" => "2004-02-26",
                      "airtime" => "20:00",
                      "airstamp" => "2004-02-27T01:00:00+00:00",
                      "runtime" => 30,
                      "image" => { "medium" => "https://static.tvmaze.com/uploads/images/medium_landscape/197/492532.jpg",
                                  "original" => "https://static.tvmaze.com/uploads/images/original_untouched/197/492532.jpg" },
                      "summary" => "<p>Monica and Chandler visit their house,
  which is in escrow,
  where Joey is comforted about losing his friends by the 8-year-old girl who presently lives there. Phoebe learns that she can change her name to whatever she wants,
  which turns out to be Princess Consuela Bananahammock. After Mike changes his name to Crap Bag,
  she decides to just be Phoebe Buffay-Hannigan. Ross gets tenure at his job. Rachel's boss is sitting next to her at an interview,
  and she loses her job. However,
  she runs into her old friend Mark,
  who offers her a job in Paris.</p>",
                      "_links" => { "self" => { "href" => "https://api.tvmaze.com/episodes/40877" } } }
    episode = Episode.new(episode_data)
    expect(episode.name).to eq("The One With Princess Consuela")
    expect(episode.season).to eq(10)
    expect(episode.number).to eq(14)
    expect(episode.airdate).to eq("2004-02-26")
    expect(episode.summary).to eq(episode_data["summary"])
  end

  describe ".all" do
    it "returns an array of all the episodes within the friends hash" do 
      expect(Episode.all).to be_a(Array)
      expect(Episode.all.size).to eq(236)
      expect(Episode.all.first).to be_a(Episode)
      expect(Episode.all.first.name).to eq("The One Where Monica Gets a Roommate")
      expect(Episode.all.last.name).to eq("The Last One,\n  Part 2")
    end
  end
end
