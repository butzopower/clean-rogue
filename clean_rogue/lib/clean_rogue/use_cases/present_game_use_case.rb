module CleanRogue
  module UseCases
    class PresentGameUseCase
      def initialize(observer:, game_repo:, game_id:)
        @observer = observer
        @game_repo = game_repo
        @game_id = game_id
      end

      def execute
        game = @game_repo.find(@game_id)
        @observer.game_presented(game)
      end
    end
  end
end