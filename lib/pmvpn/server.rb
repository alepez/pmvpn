require 'pmvpn'
require 'yaml'
require 'pmvpn/slots'

module PMVpn
  class Server

    attr_reader :settings

    public
    # Constructor
    def initialize
      @settings = load_settings("#{Dir.home}/.config/pmvpn/server.conf")
      @slots = Slots.new(self)
    end

    # Show usage
    def help(params = nil)
      puts %q{
Poor Man Vpn Server
===================

      }
    end

    # Return new slot configurations
    def connect(params = nil)
      begin
        slot = @slots.add(params[0])
        print YAML::dump(slot.data) if slot
      rescue Exception => e
        die e.message
      end
    end

    # Return new slot configurations
    def disconnect(params = nil)
      begin
        slot = @slots.del_by_id(params[0].to_i)
        print YAML::dump(slot.data) if slot
      rescue Exception => e
        die e.message
      end
    end

    private

    # Handle errors, show a message and exit
    def die(message)
      puts message
      exit 1
    end

    # Load configuration
    def load_settings(filename)
      die "Cannot load settings from #{filename}" unless File.exists?(filename)
      YAML::load(File.open(filename))
    end

  end
end