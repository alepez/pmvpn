require 'yaml'

module PMVpn
  class Client

    public
    # Constructor
    def initialize
      @settings = load_settings("#{Dir.home}/.config/pmvpn/client.conf")
    end

    # Connect
    def connect(params = nil)
      
    end

    # Show usage
    def help(params = nil)
      puts <<-eos
Poor Man Vpn Client
      eos
    end

    private

    # Load configuration
    def load_settings(filename)
      die "Cannot load settings from #{filename}" unless File.exists?(filename)
      YAML::load(File.open(filename))
    end

  end
end