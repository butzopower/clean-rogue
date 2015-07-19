require "securerandom"

class FakeGameRepo
  def initialize
    @games = {}
  end

  def save(game)
    game.id = SecureRandom.uuid
    @games[game.id] = game
  end

  def find(id)
    @games[id]
  end

  def all
    @games.values
  end
end
