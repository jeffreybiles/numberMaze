ig.module('game.entities.gui.completedLevel').requires(
  'game.entities.gui.rectangle',
  'game.entities.gui.textBox'
).defines ->

  window.EntityCompletedLevel = EntityRectangle.extend(
    init: (x, y, settings) ->
      @parent(100, 100, settings)
      @width = ig.system.width - 200
      @height = ig.system.height - 200
      @backgroundColor = '#ddd'
      @borderColor = '#975'
      @borderSize = 3
      ig.game.spawnEntity(EntityTextBox, ig.system.width/2 - 100, ig.system.height - 250, {
            width: 200, height: 100, backgroundColor: 'white',
            borderColor: 'green', borderSize: '2', text: 'Helloooo let us test line breaks on text', zIndex: 10})
  )
