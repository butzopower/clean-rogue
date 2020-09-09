module Controllers
  class KeyboardController
    def initialize(key_map)
      @key_map = key_map
    end

    def await_input
      Dispel::Keyboard.output do |key|
        yield map_key(key)
      end
    end

    def map_key(key)
      case key
      when :enter
        :enter
      when 'c'
        :toggle
      when 'q'
        :quit
      else
        @key_map.map_key_to_input(key)
      end
    end
  end
end