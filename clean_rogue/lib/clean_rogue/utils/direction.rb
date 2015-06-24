module Direction
  N = [0,-1]
  NE = [1,-1]
  E = [1,0]
  SE = [1,1]
  S = [0,1]
  SW = [-1,1]
  W = [-1,0]
  NW = [-1,-1]
  WAIT = [0,0]
  UP = -1
  DOWN = 1

  DIRECTIONS = [:N, :NE, :E, :SE, :S, :SW, :W, :NW, :WAIT, :UP, :DOWN]

  DIRECTIONS.each do |direction|
    define_singleton_method(direction) { const_get(direction) }
  end
end