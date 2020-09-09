module Controllers
  module StandardKeyMap
    def self.map_key_to_input(key)
      case key
      when :up, :down, :left, :right
        key
      else
        :unknown
      end
    end
  end
end