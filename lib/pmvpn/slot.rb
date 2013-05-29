require 'pmvpn'
require 'yaml'

module PMVpn
  class Slot

    attr_reader :name, :id, :remote_port, :monitor_port
    
    # Constructor
    def initialize(name, id, slots)
      @name = name
      @id = id
      @slots = slots
    end

    # Remote port
    def remote_port
      @slots.parent.settings['port_start'] + (id * 3)
    end

    # Monitor port
    def monitor_port
      @slots.parent.settings['port_start'] + (id * 3) + 1
    end

    def data
      {'name' => @name, 'id' => @id }
    end
  end
end
