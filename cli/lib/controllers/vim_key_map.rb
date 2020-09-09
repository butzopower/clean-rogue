module Controllers
  module VimKeyMap
    def self.map_key_to_input(key)
      case key
      when 'h'
        :left
      when 'l'
        :right
      when 'j'
        :down
      when 'k'
        :up
      when 'b'
        :down_left
      when 'n'
        :down_right
      when 'y'
        :up_left
      when 'u'
        :up_right
      else
        :unknown
      end
    end
  end
end