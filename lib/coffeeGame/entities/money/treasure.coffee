ig.module(
  'game.entities.money.treasure'
)
.requires(
  'game.entities.money.moneyGranter'
)
.defines ->
  window.EntityTreasure = EntityMoneyGranter.extend(
    id: null
    used: null

    check: ->
      if(ig.game.storage.isSet('treasure' + @id))
        @used = ig.game.storage.get('treasure' + @id)

      @parent()
      ig.game.storage.set('treasure' + @id, 'true')
      ig.game.record('treasure', "#{@id} #{@used}", null, @amountGained)
      ig.game.spawnEntity(EntityCompletedLevel,null, null, {money: @amount(), id: @id})

    amount: ->
      if @used
        @baseline() * 10
      else
        @baseline() * 30

    draw: ->
      @font.draw("#", @pos.x - @offset.x - ig.game.screen.x, @pos.y - @offset.y - ig.game.screen.y)
  )