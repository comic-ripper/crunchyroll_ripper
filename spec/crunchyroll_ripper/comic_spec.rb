require 'spec_helper'

describe CrunchyrollRipper::Comic, vcr: true do
  subject(:comic) { CrunchyrollRipper::Comic.new series_id: series_id }
  let(:series_id) { 197 }

  describe "#chapters" do
    it "stuff" do
      expect(comic.chapters.first).to be_a CrunchyrollRipper::Chapter
    end
  end

  describe "serialization" do
    it "will serialize series_id" do
      expect(JSON.load(comic.to_json).series_id).to eql series_id
    end
  end
end
