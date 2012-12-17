ig.module(
  'game.entities.money.moneyGranter'
)
.requires(
  'impact.entity',
  'game.entities.utility.message'
)
.defines ->
  window.EntityMoneyGranter = ig.Entity.extend(
    size: {x: 48, y: 48}
    font: new ig.Font( 'media/helvetica64EEE.png' )
    checkAgainst: ig.Entity.TYPE.A
    path: 1

    check: ->
      ig.game.stats.money += @amount();
      message = ig.game.spawnEntity(EntityMessage, "+ $" + @amount())
      message.pos.y += 50
      @kill()

    amount: ->
      @baseline()

    baseline: ->
      Math.round(Math.pow(1.6, @path + 1))
  )