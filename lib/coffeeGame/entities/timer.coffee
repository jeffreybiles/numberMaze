ig.module(
  'game.entities.timer'
)
.requires(
  'impact.entity',
  'impact.font',
  'plugins.font'
)
.defines ->
  window.EntityTimer = ig.Entity.extend(
    font: new Font( 'bold 30px Helvetica' )
    centering: ig.Font.ALIGN.CENTER
    lifetime: 1
    timer: null

    init: (message) ->
      @timer = new ig.Timer();
      @timer.set(@max())
      ig.Timer.timeScale = 1.2
      @pos = {x: ig.system.width/2, y: ig.system.height/2};

    update: ->
      if ig.game.state == 'paused'
        @timer.pause()
      else
        @timer.unpause()
      ig.game.goToCenter() if @timeLeft() <= 0
      @parent()

    timeLeft: ->
      Math.round(-1*@timer.delta())

    draw: ->
      @font.draw(@timeLeft(), 860, 20, 'left', '#EEE')

    max: ->
      90 + 15*ig.game.stats.timeIncreases

    change: (amount) ->
      @timer.set(-@timer.delta() + amount)
  )