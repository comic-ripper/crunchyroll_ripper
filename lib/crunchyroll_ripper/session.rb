module CrunchyrollRipper
  class Session

    attr_accessor :username, :password, :auth_data

    def self.from_env
      new username: ENV["CRUNCHYROLL_USERNAME"], password: ENV["CRUNCHYROLL_PASSWORD"]
    end

    def initialize username:, password:, **args
      @username = username
      @password = password
    end

    def authenticate
      start_session
      login
    end

    def token
      authenticate unless authenticated?

      @auth_data["auth"]
    end

    def id
      authenticate unless authenticated?
      @session_id
    end

    def authenticated?
      !@auth_data.nil? && !expired?
    end

    def expired?
      Time.parse(@auth_data["expires"]) <= Time.now
    end

    private

    def start_session
      session_start = JSON.load RestClient.post(
        "http://api-manga.crunchyroll.com/cr_start_session",
        device_type: "com.crunchyroll.crunchyroid",
        device_id: "16b34eb91a09fe7a",
        access_token: "1M8BbXptBS4VhMP",
        version: 0,
        format: 'json'
      )
      @session_id = session_start["data"]["session_id"]
    end

    def login
      request = JSON.load RestClient.post(
        "http://api-manga.crunchyroll.com/cr_login",
        account: username,
        password: password,
        session_id: @session_id,
        version: 0,
        format: 'json'
      )
      @auth_data = request["data"]
      raise request.inspect unless authenticated?
    end
  end
end
