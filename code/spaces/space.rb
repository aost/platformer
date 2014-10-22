class Space
  class << self
    attr_accessor :width, :height, :background_color, :things

    def size
      [@width, @height]
    end

    def size=(value)
      @width, @height = value
    end
  end

  attr_accessor :width, :height, :background_color, :things

  def initialize
    @width, @height = self.class.size
    @background_color = self.class.background_color || Color['#ccc']

    @things = self.class.things.inject([]) do |memo, data|
      type, positions = data

      positions.each do |position|
        memo << type.new(*position)
      end

      memo
    end
  end

  def update(elapsed, game)
    @things.each do |thing|
      thing.update(game)
    end
  end

  def draw(display)
    display.fill_color = @background_color
    display.clear

    @things.each { |t| t.draw(display) }
  end
end
