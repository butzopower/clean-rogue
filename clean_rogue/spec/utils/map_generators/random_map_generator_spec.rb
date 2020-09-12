require 'clean_rogue/utils/map_generators/random_map_generator'
require 'clean_rogue/values/player'

describe "generating a completely random map" do
  let(:height) { 2 }
  let(:width) { 3 }
  let(:number_of_obstacles) { 3 }
  let(:number_of_items) { 2 }
  let(:room_options) { {height: height, width: width, number_of_obstacles: number_of_obstacles, number_of_items: number_of_items }}
  let(:seed) { rand(1000000) }

  it "builds the room with the configured dimensions" do
    room = generate_room
    expect(room.width).to eq(width)
    expect(room.height).to eq(height)
  end

  it "builds the room with the configured obstacles" do
    room = generate_room
    expect(room.obstacles.size).to eq(number_of_obstacles)
  end

  it "builds the room with the configured items" do
    room = generate_room
    expect(room.items.size).to eq(number_of_items)
  end

  context "when the game has been configured with a seed" do
    let(:seed) { 12345 }

    describe "when building a map" do
      it "creates the same map" do
        original_room_obstacle_positions = generate_room.obstacles.map(&:position)
        new_room_obstacle_positions = generate_room.obstacles.map(&:position)

        expect(new_room_obstacle_positions).to eq(original_room_obstacle_positions)
      end
    end
  end

  def generate_room
    rng = Random.new(seed)
    player = CleanRogue::Values::Player.new(position: [0,0])

    CleanRogue::Utils::MapGenerators::RandomMapGenerator.new(
      room_options: room_options,
      rng: rng
    ).build_room(player)
  end
end


