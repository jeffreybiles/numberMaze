ig.module(
  'game.entities.money.chest'
)
.requires(
  'game.entities.money.moneyGranter'
)
.defines ->
  window.EntityChest = EntityMoneyGranter.extend(
    type: 'chest'
    id: null
    used: null

    killIfAlreadyUsed: ->
      if(ig.game.storage.isSet("chest#{@id}"))
        @kill()
      else
        @used = false

    update: ->
      if(@used == null)
        @killIfAlreadyUsed()

    check: ->
      @parent()
      ig.game.storage.set("chest#{@id}", true)
      ig.game.record("chest", @id, null, @amount)

    amount: ->
      @baseline() * 30

    draw: ->
      @font.draw("#", @pos.x - @offset.x - ig.game.screen.x, @pos.y - @offset.y - ig.game.screen.y)
  )