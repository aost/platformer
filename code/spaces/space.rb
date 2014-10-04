class Space
  class << self
    attr_accessor :size, :background_color, :things
  end

  attr_accessor :size, :background_color, :things

  def initialize
    @size = self.class.size
    @background_color = self.class.background_color || C['#ccc']

    @things = self.class.things.inject([]) do |memo, data|
      type, positions = data
      positions = [positions] if positions.respond_to? :components

      positions.each do |position|
        memo << type.new(position)
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
