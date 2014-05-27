require 'json'
require 'rest-client'

module CrunchyrollRipper


  class Chapter
    attr_accessor :chapter_id, :number, :session

    def initialize chapter_id:, number:, session: Session.from_env, **args
      @chapter_id = chapter_id
      @number = number
      @session = session
      @args = args
    end

    def document
      @document ||= JSON.load RestClient.get(
        "http://api-manga.crunchyroll.com/list_chapter",
        params:{
          session_id: @session.id,
          format: 'json',
          chapter_id: @chapter_id,
          auth: @session.token,
          version: 0
        }
      )
    end

    def pages
      document["pages"].map do |page|
        Page.new(
          number: page["number"],
          url: page["locale"]["enUS"]["encrypted_composed_image_url"],
          extra: page
        )
      end
    end


    def to_json a = nil
      {
        JSON.create_id => self.class.name,
        chapter_id: chapter_id,
        number: number
      }.to_json a
    end

    def self.json_create data
      new(chapter_id: data["chapter_id"], number: data["number"])
    end
  end
end
