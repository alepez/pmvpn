require 'pmvpn'
require 'yaml'
require 'pmvpn/slot'

module PMVpn

  attr_reader :parent
  class Slots

    @@db = "#{Dir.home}/.config/pmvpn/server.slots"
    # Constructor
    def initialize(parent)
      @children = load
      @parent = parent
    end

    # Return an array with slots data
    def data
      @children.collect { |slot| slot.data }
    end

    # Save to database
    def save
      YAML::dump(data, File.open(@@db, "w"))
    end

    def has_name(name)
      @children.select { |slot| slot.name == name }.size > 0
    end
    
    def has_id(id)
      (@children.select { |slot| slot.id == id }).size > 0
    end
    
    # Return an hash with next free slot settings
    def add(name)
      raise ArgumentError, "A slot with name = '#{name}' already exists" if has_name(name)
      new_id = @children.empty? ?  1 : @children.last.id + 1
      new_slot = Slot.new(name, new_id, self)
      @children << new_slot
      save
      new_slot
    end

    # Remove a slot by id
    def del_by_id(id)
      raise ArgumentError, "A slot with id = '#{id}' does not exist" unless has_id(id)
      to_remove = @children.select { |slot| slot.id == id }
      @children.delete_if { |slot| slot.id == id }
      save
      to_remove.first
    end

    # Remove all slot by name
    def del_by_name(name)
      to_remove = @children.select { |slot| slot.name == name }
      @children.delete_if { |slot| slot.name == name }
      save
      to_remove
    end

    private

    # Load from database
    def load
      die "Cannot load slots from #{@@db}" unless File.exists?(@@db)
      slots_data = YAML::load(File.open(@@db))
      slots_data = [] unless slots_data
      children = []
      slots_data.each { |slot_data| children << Slot.new(slot_data['name'], slot_data['id'], self) }
      children
    end

  end
end
