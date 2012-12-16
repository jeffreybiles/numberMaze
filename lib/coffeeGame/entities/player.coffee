ig.module(
  'game.entities.player'
)
.requires(
  'impact.entity'
)
.defines ->

  window.EntityPlayer = ig.Entity.extend(
    collides: ig.Entity.COLLIDES.ACTIVE
    type: ig.Entity.TYPE.A
    additionLevel: 0
    subtractionLevel: 0

    size: {x:32, y:32}
    offset: {x: 8, y:8}
    animSheet: new ig.AnimationSheet( 'media/puck.png', 48, 48 )

    moveSpeed: 140
    maxVel: {x: 200, y:200}

    init: ( x, y, settings ) ->
      @parent( x, y, settings );
      @addAnim( 'idle', 0.1, [0,1,2,3,4,4,4,4,3,2,1] );

    update: ->
      if (ig.game.state == 'main')
        @vel.x = 0
        @vel.y = 0
        if ig.input.state('click')
          dx = ig.input.mouse.x - ig.system.width/2
          dy = ig.input.mouse.y - ig.system.height/2
          if Math.abs(dx) > Math.abs(dy)
            @vel.x = Math.abs(dx)/dx * @moveSpeed
          else
            @vel.y = Math.abs(dy)/dy * @moveSpeed

        else if( ig.input.state('up') )
          @vel.y = -@moveSpeed;
        else if( ig.input.state('down') )
          @vel.y = @moveSpeed;
        else
          if(ig.input.state('left'))
            @vel.x = -@moveSpeed
          else if( ig.input.state('right'))
            @vel.x = @moveSpeed



        @parent();
  )