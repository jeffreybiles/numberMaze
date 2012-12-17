ig.module(
  'game.entities.money.cash'
)
.requires(
  'game.entities.money.moneyGranter'
)
.defines ->
  window.EntityCash = EntityMoneyGranter.extend(
    check: ->
      @parent()
      ig.game.record('cash', "#{@path}", null, @amount)

    draw: ->
      @font.draw("$", @pos.x - @offset.x - ig.game.screen.x, @pos.y - @offset.y - ig.game.screen.y)
  )