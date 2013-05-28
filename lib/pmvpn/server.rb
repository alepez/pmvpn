require 'pmvpn'
require 'yaml'

module PMVpn
  class Server

    public
    # Constructor
    def initialize
      load_settings(@@settings_filename)
      load_slots(@@slots_filename)
    end

    # Show usage
    def help(params = nil)
      puts <<-eos
Poor Man Vpn Server
eos
    end

    # Return new slot configurations
    def connect(params = nil)
      slot = add_slot(params[0])
      print YAML::dump(slot)
    end

    # Return new slot configurations
    def disconnect(params = nil)
      del_slot(params[0])
    end
    
    private

    @@settings_filename = "#{Dir.home}/.config/pmvpn/server.conf"
    @@slots_filename = "#{Dir.home}/.config/pmvpn/server.slots"

    # Handle errors, show a message and exit
    def die(message)
      puts message
      exit 1
    end

    # Load configuration
    def load_settings(filename)
      die "Cannot load settings from #{filename}" unless File.exists?(filename)
      @settings = YAML::load(File.open(filename))
    end

    # Load slots
    def load_slots(filename)
      die "Cannot load slots from #{filename}" unless File.exists?(filename)
      @slots = YAML::load(File.open(filename))
      @slots = [] unless @slots
    end
    
    # Save slots
    def save_slots
      YAML::dump(@slots, File.open(@@slots_filename, "w"))
    end

    # Return an hash with next free slot settings
    def add_slot(name)
      id = @slots.empty? ?  1 : @slots.last['id'] + 1
      slot = {
        'name' => name,
        'id' => id,
        'remote_port' => get_remote_port(id),
        'monitor_port' => get_monitor_port(id)
      }
      @slots << slot
      save_slots
      slot
    end
    
    # Remove a slot
    def del_slot(id)
      @slots.delete_if { |slot| slot['id'] == id }
      save_slots
    end

    # Return remote port for given id
    def get_remote_port(id)
      @settings['port_start'] + (id * 3)
    end

    # Return monitor port for given id
    def get_monitor_port(id)
      @settings['port_start'] + (id * 3) + 1
    end
  end
end