ig.module(
  'game.entities.chest'
)
.requires(
  'impact.entity'
)
.defines ->
  window.EntityChest = ig.Entity.extend(
    amount: 1
    type: 'money'
    id: null
    size: {x: 48, y: 48}
    font: new ig.Font( 'media/helvetica64EEE.png' )
    checkAgainst: ig.Entity.TYPE.A
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
      if(@type == 'money')
        ig.game.stats.money += @amount;
        message = ig.game.spawnEntity(EntityMessage, "+ $#{@amount}")
        message.pos.y += 50
      ig.game.storage.set("chest#{@id}", true)
      ig.game.record("chest", @id, null, @amount)
      @kill()

    draw: ->
      @font.draw("#", @pos.x - @offset.x - ig.game.screen.x, @pos.y - @offset.y - ig.game.screen.y)
  )