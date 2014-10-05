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


  def initialize(position)
    super

    @initial_position = position
    @velocity = V[0, 0]
    @direction = V[0, 0]
    @facing = 1
    @jump_frames = INITIAL_JUMP_FRAMES
    @airborne = true
  end

  def update(game)
    # Direction based on input
    @direction = V[0, 0]
    @direction.x += 1 if game.keyboard.pressing? :right
    @direction.x -= 1 if game.keyboard.pressing? :left
    @direction.y += 1 if game.keyboard.pressing? :z


    @facing = @direction.x unless @direction.x == 0


    # Running
    @velocity.x += @direction.x * RUN_ACCELERATION
    @velocity.x = MAX_RUN_SPEED if @velocity.x > MAX_RUN_SPEED
    @velocity.x = -MAX_RUN_SPEED if @velocity.x < -MAX_RUN_SPEED


    # Jumping
    if @direction.y > 0 && @jump_frames > 0
      @velocity.y = -JUMP_SPEED
      @jump_frames -= 1
      @airborne = true
    else
      @jump_frames = 0
    end


    # Gravity
    @velocity.y += GRAVITY
    @velocity.y = TERMINAL_VELOCITY if @velocity.y > TERMINAL_VELOCITY


    # Friction
    friction = @airborne ? AIR_FRICTION : GROUND_FRICTION
    if @velocity.x > 0
      @velocity.x -= [@velocity.x, friction].min
    else
      @velocity.x += [-@velocity.x, friction].min
    end


    # Movement
    self.position += @velocity


    # Collision
    game.space.things.each do |thing|
      next if thing == self

      if thing.solid?
        # Sides (wall)
        if colliding_left? thing
          @position.x = thing.x + thing.width
          @velocity.x = 0
        elsif colliding_right? thing
          @position.x = thing.x - width
          @velocity.x = 0
        end

        # Bottom (floor)
        if colliding_bottom? thing
          @position.y = thing.y - height
          @velocity.y = 0

          @jump_frames = INITIAL_JUMP_FRAMES
          @airborne = false
        # Top (ceiling)
        elsif colliding_top? thing
          @position.y = thing.y + thing.height
          @velocity.y = 0
        end
      end
    end

    if @position.y > game.space.height + 128
      @velocity = V[0, 0]
      @position = @initial_position
    end
  end

  def draw(d)
    d.push
      d.translate(V[@position.x.to_i, @position.y.to_i] + V[(width / 2).to_i, 0])
      d.scale_x(@facing)
      d.image(GRAPHIC, V[(-width / 2).to_i, 0])
    d.pop
  end

  def size
    GRAPHIC.size
  end

  private

  def point_in_bounds?(point, rect_pos, rect_size)
    point.x > rect_pos.x && point.x <= rect_pos.x + rect_size.x &&
    point.y > rect_pos.y && point.y <= rect_pos.y + rect_size.y
  end

  def colliding_top?(thing)
    point_in_bounds?(@position + V[width / 2, 0],
                     thing.position, thing.size)
  end

  def colliding_bottom?(thing)
    point_in_bounds?(@position + V[width / 2, height],
                     thing.position, thing.size)
  end

  def colliding_left?(thing)
    point_in_bounds?(@position + V[0, height / 2],
                     thing.position, thing.size)
  end

  def colliding_right?(thing)
    point_in_bounds?(@position + V[width, height / 2],
                     thing.position, thing.size)
  end
end
