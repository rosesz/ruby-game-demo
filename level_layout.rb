class LevelLayout
  def map_layout
    [
      [-1, -1, -1, -8, -8, -2, -4, -1,  0,  0,  0],
      [-1,  0,  0, -7,  0,  0,  0, -1,  0,  0,  0],
      [-1,  0,  0,  0,  0,  0,  0, -7, -3, -4, -8],
      [-1,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
      [-1,  1,  1,  0,  0,  0,  0,  5,  6,  0,  0],
      [ 0,  0,  1,  2,  3,  4,  1,  8,  0,  6,  0],
      [ 0,  0,  0,  0,  0,  0,  0,  0,  0,  3,  6]
    ]
  end

  def initialize
    @images = Gosu::Image.load_tiles("media/wall_sprite.png", 325, 365)
  end

  def tiles
    @tiles ||= begin
      map_layout.map do |row|
        row.map do |type|
          if type != 0
            z_order = type > 0 ? 2 : 0
            Tile.new(@images[type.abs - 1], z_order)
          end
        end
      end
    end
  end

  def draw
    tiles.each_with_index do |row, i|
      cell_x = tiles.size - i - 1
      row.each_with_index do |tile, cell_y|
        next unless tile
        x = (cell_x * 325 / 2) + (cell_y * 325 / 2) - 800
        y = (cell_y * 150 / 2) - (cell_x * 150 / 2)

        tile.image.draw(x, y, tile.z_order)
      end
    end
  end

  class Tile < Struct.new(:image, :z_order); end
end
