ig.module(
  'game.entities.message'
)
.requires(
  'impact.entity'
)
.defines ->
  window.EntityMessage = ig.Entity.extend(
    font: new ig.Font( 'media/helvetica30EEE.png' )
    centering: ig.Font.ALIGN.CENTER
    lifetime: 1

    init: (message) ->
      @messages = message.split('/n');
      @idleTimer = new ig.Timer();
      @pos = {x: ig.system.width/2, y: ig.system.height/2};

    update: ->
      if (@idleTimer.delta() > @lifetime)
        @kill()

    draw: ->
      for i in [0...@messages.length]
        @font.draw(@messages[i], @pos.x + 18, @pos.y + 30*i, @centering)
  )