ig.module('game.entities.gui.centeredTextBox').requires('game.entities.gui.textBox').defines ->
  window.EntityCenteredTextBox = EntityTextBox.extend(

    drawText: (text) ->
      center = @y + @height/2
      yStart = center - text.length * @fontHeight / 2
      for i in [0...text.length]
        line = text[i]
        @font.draw(line, @x + @width/2, yStart + i*@fontHeight, ig.Font.ALIGN.CENTER)

  )