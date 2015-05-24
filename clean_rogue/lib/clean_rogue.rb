require "clean_rogue/use_cases/move_player_use_case"

module CleanRogue
  extend self

  include UseCases

  def move_player(*args)
    MovePlayerUseCase.new(*args)
  end
end