require 'yaml'
require 'pmvpn/slots'

module PMVpn
  class Manager

    public
    # Constructor
    def initialize
      @settings = load_settings("#{Dir.home}/.config/pmvpn/server.conf")
      @slots = Slots.new(self)
    end

    def list(params = nil)
      print "+-----+----------------------+\n"
      print "| ID  | NAME                 |\n"
      print "+-----+----------------------+\n"
      @slots.data.each do |slot|
        id = slot['id'].to_s.rjust(3)
        name = slot['name'].ljust(20)
        print "| #{id} | #{name} |\n"
      end
      print "+-----+----------------------+\n"
    end

    def clear(params = nil)
      @slots.clear
    end

    # Show usage
    def help(params = nil)
      puts %q{
Poor Man Vpn Manager
====================

list
    List all slots

clear
    Clear all slots without disconnecting

disconnect_all
    Disconnect all slots and clear

      }
    end

    private

    # Load configuration
    def load_settings(filename)
      die "Cannot load settings from #{filename}" unless File.exists?(filename)
      YAML::load(File.open(filename))
    end

    # Handle errors, show a message and exit
    def die(message)
      puts message
      exit 1
    end

  end
end