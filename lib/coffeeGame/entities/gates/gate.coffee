ig.module('game.entities.gates.gate').requires(
  'impact.entity',
  'game.entities.message',
  'game.entities.gui.problemInterface'
).defines ->
  window.EntityGate = ig.Entity.extend(
    interface: null
    spriteSize: {x: 48, y: 48}
    size: {x: 48, y: 48}
    difficulty: 1
    font: new ig.Font( 'media/helvetica32000.png')
    _wmScalable: true

    collides: ig.Entity.COLLIDES.FIXED
    checkAgainst: ig.Entity.TYPE.A

    init: ( x, y, settings ) ->
      @parent x, y, settings
      @animSheet =  new ig.AnimationSheet( 'media/tileset.png', @spriteSize.x, @spriteSize.y );

    check: ->
      @parent()

      if ig.game.state == 'main'
        if @passable()
          @makeChallenge()
        else
          ig.game.spawnEntity(EntityMessage, @failMessage())

    makeChallenge: ->
      ig.game.state = 'problem'
      ig.game.gate = @
      @makeQuestion()

    failMessage: ->
      ig.game.record("#{@gateType}Gate", "unpassable", @difficulty) if ig.game.getEntitiesByType(EntityMessage).length == 0
      "The door won't budge./nYour powers of #{@gateType} are not yet strong enough."

    resolve: ->
      @interface.kill()
      ig.game.state = 'main'

    draw: ->
      ctx = ig.system.context;
      ctx.save();
      ctx.translate( ig.system.getDrawPos( @pos.x - @offset.x - ig.game.screen.x ),
        ig.system.getDrawPos( @pos.y - @offset.y - ig.game.screen.y ) );
      numColumns = Math.floor(@size.x/@spriteSize.x);
      numRows = Math.floor(@size.y/@spriteSize.y);
      for i in [0...numColumns]
        for j in [0...numRows]
          @currentAnim.draw(i*@spriteSize.x, j*@spriteSize.y)
      @font.draw(@difficulty, 5, 5)
      ctx.restore();
  )