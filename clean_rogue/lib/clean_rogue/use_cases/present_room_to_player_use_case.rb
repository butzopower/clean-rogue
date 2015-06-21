require "clean_rogue/utils/field_of_view_calculation"
require "clean_rogue/values/vision"

module CleanRogue
  module UseCases
    class PresentRoomToPlayerUseCase
      def initialize(observer:, room:, player:)
        @observer = observer
        @room = room
        @player = player
        @field_of_view_calculator = Utils::FieldOfViewCalculation.new(room: @room, player: @player)
      end

      def execute
        vision = build_vision
        @observer.vision_presented(vision)
      end

      private

      def build_vision
        visible_positions = @field_of_view_calculator.calculate_visible_positions
        Values::Vision.new(visible_positions: visible_positions)
      end
    end
  end
end