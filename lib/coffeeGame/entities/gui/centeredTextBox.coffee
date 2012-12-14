ig.module('game.entities.gui.centeredTextBox').requires('game.entities.gui.textBox').defines ->
  window.EntityCenteredTextBox = EntityTextBox.extend(
    init: (x, y, settings) ->
      @parent(x, y, settings)
      @ctx.textAlign = 'center'
      @ctx.textBaseline = 'middle'

    drawText: ->
      @ctx.fillText(@text, @x + @width/2, @y + @height/2)
  )