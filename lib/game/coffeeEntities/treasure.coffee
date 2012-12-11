ig.module(
  'game.entities.treasure'
)
.requires(
  'impact.entity'
)
.defines ->
  window.EntityTreasure = ig.Entity.extend(
    amount: 1
    id: null
    size: {x: 48, y: 48}
    font: new ig.Font( 'media/helvetica64EEE.png' )
    checkAgainst: ig.Entity.TYPE.A
    used: null

    check: ->
      if(ig.game.storage.isSet('treasure' + @id))
        @used = ig.game.storage.get('treasure' + @id)

      if(@used)
        amountUsed = Math.round(@amount/3);
      else
        amountUsed = @amount;
      ig.game.stats.money += amountUsed;

      message = ig.game.spawnEntity(EntityMessage, "+ $" + amountUsed + '/nGood job!')
      message.pos.y += 50
      ig.game.storage.set('treasure' + @id, 'true')
      @kill()
      setTimeout( ->
        ig.game.goToCenter();
      , 1500)

    draw: ->
      @font.draw("#", @pos.x - @offset.x - ig.game.screen.x, @pos.y - @offset.y - ig.game.screen.y)
  )