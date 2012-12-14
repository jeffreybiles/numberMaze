ig.module(
  'game.entities.timer'
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
      ig.game.goToCenter() if @timeLeft() <= 0
      @parent()

    timeLeft: ->
      Math.round(-1*@timer.delta())

    draw: ->
      @font.draw(@timeLeft(), ig.system.width - 100, 20, @centering)

    max: ->
      90 + 15*ig.game.stats.timeIncreases

    change: (amount) ->
      #make something here that calls attention to the amount
      @timer.set(-@timer.delta() + amount)
  )