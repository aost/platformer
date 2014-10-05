class Wall < Thing
  def update(game)
  end

  def draw(d)
    d.image(graphic, @position)
  end

  def size
    graphic.size
  end

  def solid?
    true
  end

  def graphic
    @graphic ||= Image['wall.png']
  end
end
