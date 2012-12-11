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

    moveSpeed: 200
    maxVel: {x: 800, y:800}

    init: ( x, y, settings ) ->
      @parent( x, y, settings );
      @addAnim( 'idle', 0.1, [0,1,2,3,4,4,4,4,3,2,1] );

    update: ->
      if (ig.game.state == 'main')
        if( ig.input.state('up') )
          @vel.y = -@moveSpeed;
          @vel.x = 0
        else if( ig.input.state('down') )
          @vel.x = 0
          @vel.y = @moveSpeed;
        else
          @vel.y = 0
          if(ig.input.state('left'))
            @vel.x = -@moveSpeed
          else if( ig.input.state('right'))
            @vel.x = @moveSpeed
          else
            @vel.x = 0

        @parent();
  )