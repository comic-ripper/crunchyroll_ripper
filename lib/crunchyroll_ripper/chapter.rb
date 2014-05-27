require 'json'
require 'rest-client'

module CrunchyrollRipper
  class Chapter
    def initialize chapter_id:, **args
      @chapter_id = chapter_id
      @args = args
    end

    def document
      RestClient.get "http://api-manga.crunchyroll.com/list_chapter", chapter_id: @chapter_id
    end
  end
end
