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
        amountGained = Math.round(@amount/3);
      else
        amountGained = @amount;
      ig.game.stats.money += amountGained;

      ig.game.storage.set('treasure' + @id, 'true')
      ig.game.record('treasure', "#{@id} #{@used}", null, @amountGained)
      ig.game.spawnEntity(EntityCompletedLevel,null, null, {money: amountGained, id: @id})
      @kill()

    draw: ->
      @font.draw("#", @pos.x - @offset.x - ig.game.screen.x, @pos.y - @offset.y - ig.game.screen.y)
  )