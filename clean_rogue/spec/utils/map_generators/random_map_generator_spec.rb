require 'clean_rogue/utils/map_generators/random_map_generator'
require 'clean_rogue/values/player'

describe "generating a completely random map" do
  let(:height) { 5 }
  let(:width) { 3 }
  let(:number_of_obstacles) { 5 }
  let(:number_of_items) { 4 }
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

  it "builds the room with an entrance in the middle with no item or obstacle" do
    10.times do
      center = [width / 2, height / 2]
      room = generate_room

      expect(room.entrance.position).to eq(center)
      expect(room.obstacles.map(&:position)).to_not include(center)
      expect(room.items.map(&:position)).to_not include(center)
    end
  end

  it "builds the room without the player in it" do
    room = generate_room
    expect(room.player).to be_nil
  end

  context "when there are more obstacles than can fit" do
    let(:number_of_obstacles) { height * width + 1 }

    it "throws an error" do
      expect(-> { generate_room }).to raise_exception
    end
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

    CleanRogue::Utils::MapGenerators::RandomMapGenerator.new(
      room_options: room_options,
      rng: rng
    ).build_room
  end
end


