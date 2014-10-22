class Player < Thing
  GRAPHIC = Image['player.png']

  RUN_ACCELERATION = 2
  MAX_RUN_SPEED = 6
  JUMP_SPEED = 8
  INITIAL_JUMP_FRAMES = 6
  GRAVITY = 1
  GROUND_FRICTION = 1
  AIR_FRICTION = 0.3
  TERMINAL_VELOCITY = 6


  def initialize(x, y)
    super

    @initial_x, @initial_y = x, y
    @velocity_x, @velocity_y = 0, 0
    @direction_x, @direction_y = 0, 0
    @facing = 1
    @jump_frames = INITIAL_JUMP_FRAMES
    @airborne = true
  end

  def update(game)
    # Direction based on input
    @direction_x, @direction_y = 0, 0
    @direction_x += 1 if game.keyboard.pressing? :right
    @direction_x -= 1 if game.keyboard.pressing? :left
    @direction_y += 1 if game.keyboard.pressing? :z


    @facing = @direction_x unless @direction_x == 0


    # Running
    @velocity_x += @direction_x * RUN_ACCELERATION
    @velocity_x = MAX_RUN_SPEED if @velocity_x > MAX_RUN_SPEED
    @velocity_x = -MAX_RUN_SPEED if @velocity_x < -MAX_RUN_SPEED


    # Jumping
    if @direction_y > 0 && @jump_frames > 0
      @velocity_y = -JUMP_SPEED
      @jump_frames -= 1
      @airborne = true
    else
      @jump_frames = 0
    end


    # Gravity
    @velocity_y += GRAVITY
    @velocity_y = TERMINAL_VELOCITY if @velocity_y > TERMINAL_VELOCITY


    # Friction
    friction = @airborne ? AIR_FRICTION : GROUND_FRICTION
    if @velocity_x > 0
      @velocity_x -= [@velocity_x, friction].min
    else
      @velocity_x += [-@velocity_x, friction].min
    end


    # Movement
    @x += @velocity_x
    @y += @velocity_y


    # Collision
    game.space.things.each do |thing|
      next if thing == self

      if thing.solid?
        # Sides (wall)
        if colliding_left? thing
          @x = thing.x + thing.width
          @velocity_x = 0
        elsif colliding_right? thing
          @x = thing.x - width
          @velocity_x = 0
        end

        # Bottom (floor)
        if colliding_bottom? thing
          @y = thing.y - height
          @velocity_y = 0

          @jump_frames = INITIAL_JUMP_FRAMES
          @airborne = false
        # Top (ceiling)
        elsif colliding_top? thing
          @y = thing.y + thing.height
          @velocity_y = 0
        end
      end
    end

    if @y > game.space.height + 128
      @velocity_x = 0
      @velocity_y = 0
      @x = @initial_x
      @y = @initial_y
    end
  end

  def draw(d)
    d.push
      d.translate((@x + width / 2).to_i, @y.to_i)
      d.scale_x(@facing)
      d.draw_image(GRAPHIC, (-width / 2).to_i, 0)
    d.pop
  end

  def width
    GRAPHIC.width
  end

  def height
    GRAPHIC.height
  end

  private

  def point_in_bounds?(point_x, point_y, rect_x, rect_y, rect_width, rect_height)
    point_x > rect_x && point_x <= rect_x + rect_width &&
    point_y > rect_y && point_y <= rect_y + rect_height
  end

  def colliding_top?(thing)
    point_in_bounds?(@x + width / 2, @y,
                     thing.x, thing.y, thing.width, thing.height)
  end

  def colliding_bottom?(thing)
    point_in_bounds?(@x + width / 2, @y + height,
                     thing.x, thing.y, thing.width, thing.height)
  end

  def colliding_left?(thing)
    point_in_bounds?(@x, @y + height / 2,
                     thing.x, thing.y, thing.width, thing.height)
  end

  def colliding_right?(thing)
    point_in_bounds?(@x + width, @y + height / 2,
                     thing.x, thing.y, thing.width, thing.height)
  end
end
