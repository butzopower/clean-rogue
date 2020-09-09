#!/usr/bin/env ruby

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require "dispel"
require "runner"
require "screen"
require "views/title"
require "controllers/keyboard_controller"
require "controllers/standard_key_map"
require "controllers/vim_key_map"

Dispel::Screen.open do |dispel_screen|
  screen = Screen.new(dispel_screen)
  controller = Controllers::KeyboardController.new(Controllers::StandardKeyMap)

  @choice = :standard

  screen.present Views::Title.new(@choice)

  controller.await_input do |input|
    case input
    when :toggle
      if @choice == :standard
        @choice = :vim
        controller = Controllers::KeyboardController.new(Controllers::VimKeyMap)
      else
        @choice = :standard
        controller = Controllers::KeyboardController.new(Controllers::StandardKeyMap)
      end

      screen.present Views::Title.new(@choice)
    when :enter
      break
    when :quit
      exit
    end
  end

  @runner = Runner.new(dispel_screen)
  @runner.start

  controller.await_input do |input|
    case input
    when :up
      @runner.move_player(Direction.N)
    when :down
      @runner.move_player(Direction.S)
    when :left
      @runner.move_player(Direction.W)
    when :right
      @runner.move_player(Direction.E)
    when :up_left
      @runner.move_player(Direction.NW)
    when :up_right
      @runner.move_player(Direction.NE)
    when :down_left
      @runner.move_player(Direction.SW)
    when :down_right
      @runner.move_player(Direction.SE)
    when :wait
      @runner.move_player(Direction.WAIT)
    when :quit
      break
    end
  end
end