require 'spec_helper'

describe CrunchyrollRipper::Chapter, vcr: true do
  let(:comic) { CrunchyrollRipper::Comic.new series_id: series_id }
  let(:series_id) { 197 }
  subject(:chapter) { comic.chapters.first }

  describe "#pages" do
    it "makes Pages" do
      expect(chapter.pages.first).to be_a CrunchyrollRipper::Page
    end
  end

  describe "serialization" do
    it "will be the same" do
      serialized = JSON.load(chapter.to_json)
      expect(serialized.chapter_id).to eql chapter.chapter_id
    end
  end

end
