module Ficsr
  class Session

    class << self

      attr_accessor :username, :password

      alias_method :instance, :new
    end

    def games
      send "games", /fics/
      last_result.split("\n\r").select { |line| line =~ /^\d{3}\s\w{1,4}.*$/ }.collect do |game|
        Ficsr::Game.new game
      end
    end

    def observe(game_number, &action)
      t = Thread.new do
        send "observe #{game_number}", /fics/
        last_result.each_line("\n\r") do |line|
          action.call(line) if line =~/^<12>/
        end
      end

      t.join
    end

    def login
      send username, /password|is not a registered name/

      if registered?
        send password, /fics|login/
      else
        send "\n", /#{username}/
      end
      raise "Unable to login with username #{username} " unless logged_in?
    end

    private

    def connection
      @connection ||= Net::Telnet.new "Host" => host, "Port" => port, "Prompt" => default_prompt
    end

    def username
      Ficsr::Session.username
    end

    def password
      Ficsr::Session.password
    end

    def logged_in?
      last_result.include?("Starting FICS session as #{username}")
    end

    def send(cmd, match="", opts={}, &actions)
      all_opts = {"String" => cmd, "Match" => match}.merge opts

      if block_given?
        @last_result = connection.cmd(all_opts, &actions)
      else
        @last_result = connection.cmd(all_opts)
      end
    end

    def last_result
      @last_result
    end

    def registered?
       last_result =~ /is a registered name/
    end

    def host
      "freechess.org"
    end

    def port
      5000
    end

    def default_prompt
      /fics/
    end
  end
end
