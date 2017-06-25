require 'gosu'
require_relative 'player.rb'
require_relative 'level_layout.rb'

class GameWindow < Gosu::Window
  def initialize
    super(1280, 720, fullscreen: true)
    #super(1680, 1050, fullscreen: true)

    self.caption = "Ruby Game Demo"

    @player = Player.new(nil, 400, 100)
    @layout = LevelLayout.new
    @background_image = Gosu::Image.new("media/background.png", tileable: true)
    @draws = 0
    @buttons_down = 0
  end

  def update
    move_x = move_y = 0
    move_x -= 5 if button_down?(Gosu::KbLeft)
    move_x += 5 if button_down?(Gosu::KbRight)
    move_y -= 5 if button_down?(Gosu::KbUp)
    move_y += 5 if button_down?(Gosu::KbDown)

    @player.update(move_x, move_y)
  end

  def draw
    @draws += 1
    draw_background
    @layout.draw
    @player.draw
  end

  def button_down(id)
    close if id == Gosu::KbEscape
    @buttons_down += 1
  end

  def button_up(id)
    @buttons_down -= 1
  end

  def needs_redraw?
    @draws == 0 || @buttons_down > 0
  end

  def draw_background
    #temporary
    y = 0
    5.times do
      x = 0
      5.times do
        @background_image.draw(y, x, 0)
        x += 400
      end
    y += 400
    end
  end
end

window = GameWindow.new
window.show