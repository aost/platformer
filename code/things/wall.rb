class Wall < Thing
  def update(game)
  end

  def draw(d)
    d.draw_image(graphic, @x, @y)
  end

  def width
    graphic.width
  end

  def height
    graphic.height
  end

  def solid?
    true
  end

  def graphic
    @graphic ||= Image['wall.png']
  end
end
