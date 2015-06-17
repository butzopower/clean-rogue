#!/usr/bin/env ruby

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require "dispel"
require "runner"

KEY_PAD_TO_DIRECTIONS = {
    "1" => Direction.SW,
    "2" => Direction.S,
    "3" => Direction.SE,
    "4" => Direction.W,
    "5" => Direction.WAIT,
    "6" => Direction.E,
    "7" => Direction.NW,
    "8" => Direction.N,
    "9" => Direction.NE
}

Dispel::Screen.open do |screen|
  @runner = Runner.new(screen)
  @runner.start

  Dispel::Keyboard.output do |key|
    case key
      when "1".."9" then
        @runner.move_player(KEY_PAD_TO_DIRECTIONS[key])
      when :up then
        @runner.move_player(Direction.N)
      when :down then
        @runner.move_player(Direction.S)
      when :left then
        @runner.move_player(Direction.W)
      when :right then
        @runner.move_player(Direction.E)
      when "r" then
        @runner.start
      when "q" then
        break
    end
  end
end