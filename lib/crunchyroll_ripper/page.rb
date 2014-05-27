require 'rest-client'

module CrunchyrollRipper
  class Page

    # They use really strong XOR encryption
    MAGIC_NUMBER = 0x42

    attr_accessor :url

    def initialize url:, **args
      @url = url
    end

    def raw_image
      @raw_image ||= RestClient.get url
    end

    def image
      @decrypted ||= self.class.decrypt raw_image
    end

    def self.decrypt image_data
      image_data.bytes.map{|b| b ^ MAGIC_NUMBER }.pack("C*")
    end

    def to_json a
      {
        JSON.create_id => self.class.name,
        image_url: url
      }.to_json a
    end

    def self.json_create(data)
      new(image_url: data['image_url'])
    end
  end
end
