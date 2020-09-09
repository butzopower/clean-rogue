module Controllers
  module NumpadKeyMap
    def self.map_key_to_input(key)
      NUM_PAD_TO_DIRECTIONS.fetch(key, :unknown)
    end
  end

  NUM_PAD_TO_DIRECTIONS = {
      "1" => :down_left,
      "2" => :down,
      "3" => :down_right,
      "4" => :left,
      "5" => :wait,
      "6" => :right,
      "7" => :up_left,
      "8" => :up,
      "9" => :up_right
  }
end