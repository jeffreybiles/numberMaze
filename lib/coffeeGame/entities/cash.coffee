ig.module(
  'game.entities.cash'
)
.requires(
  'impact.entity',
  'game.entities.message'
)
.defines ->
  window.EntityCash = ig.Entity.extend(
    amount: 1
    size: {x: 48, y: 48}
    font: new ig.Font( 'media/helvetica64EEE.png' )
    checkAgainst: ig.Entity.TYPE.A

    check: ->
      ig.game.stats.money += @amount;
      console.log('you got ' + @amount)
      message = ig.game.spawnEntity(EntityMessage, "+ $" + @amount)
      message.pos.y += 50
      ig.game.record('cash', "#{@amount}", null, @amount)
      @kill()

    draw: ->
      @font.draw("$", @pos.x - @offset.x - ig.game.screen.x, @pos.y - @offset.y - ig.game.screen.y)
  )