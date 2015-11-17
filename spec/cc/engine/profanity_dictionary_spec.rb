require "spec_helper"
require "cc/engine/profanity_dictionary"

module CC::Engine
  describe ProfanityDictionary do
    let(:fixture) { File.expand_path(File.join(File.dirname(__FILE__), "../../fixtures/curses.txt")) }

    describe "#from_file" do
      it "uses what is passed" do
        dictionary = ProfanityDictionary.from_file(fixture)
        assert_equal(["fuck", "shit"], dictionary.to_a)
      end
    end

    describe "#+" do
      it "includes extras passed" do
        dictionary = ProfanityDictionary.from_file(fixture)
        dictionary + ["asshole"]
        assert_equal(["fuck", "shit", "asshole"], dictionary.to_a)
      end
    end
  end
end
