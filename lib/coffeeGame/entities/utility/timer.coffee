ig.module(
  'game.entities.utility.timer'
)
.requires(
  'impact.entity'
)
.defines ->
  window.EntityTimer = ig.Entity.extend(
    font: new ig.Font( 'media/helvetica30EEE.png' )
    centering: ig.Font.ALIGN.CENTER
    lifetime: 1
    timer: null

    init: (message) ->
      @timer = new ig.Timer();
      @timer.set(@max())
      ig.Timer.timeScale = 1.2
      @pos = {x: ig.system.width/2, y: ig.system.height/2};

    update: ->
      if ig.game.state == 'paused' then @timer.pause() else @timer.unpause()
      if @timeLeft() <= 0 then ig.game.goToCenter()
      @parent()

    timeLeft: ->
      Math.round(-1*@timer.delta())

    draw: ->
      @font.draw(@timeLeft(), 860, 20)

    max: ->
      90 + 15*ig.game.stats.timeIncreases

    change: (amount) ->
      @timer.set(-@timer.delta() + amount)
  )