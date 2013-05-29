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

    # Show usage
    def help(params = nil)
      puts <<-eos
Poor Man Vpn Manager
      eos
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