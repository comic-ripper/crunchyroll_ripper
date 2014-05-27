require 'json'
require 'rest-client'

require 'crunchyroll_ripper/chapter'

module CrunchyrollRipper
  class Comic

    attr_accessor :series_id, :session

    def initialize series_id:, session: Session.from_env, **args
      @series_id = series_id
      @session = session
    end

    def chapters
      document["chapters"].map do |chapter|
        CrunchyrollRipper::Chapter.new(
          chapter_id: chapter["chapter_id"],
          number: chapter["number"],
          volume_number: chapter["volume_number"],
          volume_id: chapter["volume_id"],
          session: session
        )
      end
    end

    def document
      @document ||= JSON.parse RestClient.get "http://api-manga.crunchyroll.com/list_chapters?series_id=#{series_id}"
    end


    def to_json a = nil
      {
        JSON.create_id => self.class.name,
        series_id: series_id
      }.to_json a
    end

    def self.json_create data
      new(series_id: data['series_id'])
    end

  end
end
