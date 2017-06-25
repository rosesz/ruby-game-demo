class Player
  attr_reader :x, :y

  def initialize(map, x, y)
    @x, @y = x, y
    turn_left
    prepare_images
    prepare_sound
  end
  
  def draw
    turn_around_value = 66

    if turned_left?
      offset_x = turn_around_value
      factor = -1.0
    else
      offset_x = turn_around_value * -1
      factor = 1.0
    end
    @current_image.draw(@x + offset_x, @y, 1, factor, 1.0)
  end
  
  def update(move_x, move_y)
    if (move_x == 0 && move_y == 0)
      @playing_sound.pause
      return
    else
      number = Gosu::milliseconds / 80 % 10
      @current_image = @images[number]
      @playing_sound.resume
    end
    
    move_x > 0 ? turn_right : turn_left

    @x += move_x
    @y += move_y
  end

  private

  def turn_right
    @direction = :right
  end

  def turn_left
    @direction = :left
  end

  def turned_right?
    @direction == :right
  end

  def turned_left?
    @direction == :left
  end

  def prepare_images
    @images = Gosu::Image.load_tiles("media/player_sprite.png", 132, 250)
    @current_image = @images[0] 
  end

  def prepare_sound
    steps_sound = Gosu::Sample.new("media/steps.mp3")
    @playing_sound = steps_sound.play(1, 1, true)
    @playing_sound.pause
  end
end
