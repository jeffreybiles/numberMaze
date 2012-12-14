ig.module('game.entities.gui.completedLevel').requires(
  'game.entities.gui.rectangle',
  'game.entities.gui.centeredTextBox'
).defines ->

  window.EntityCompletedLevel = EntityRectangle.extend(
    init: (x, y, settings) ->
      @parent(100, 100, settings)
      @width = ig.system.width - 200
      @height = ig.system.height - 200
      @backgroundColor = '#ddd'
      @borderColor = '#975'
      @borderSize = 3
      ig.game.spawnEntity(EntityCenteredTextBox, ig.system.width/2 - 100, ig.system.height - 250, {
            width: 200, height: 50, backgroundColor: 'white',
            borderColor: 'green', borderSize: '2', text: 'Helloooo', zIndex: 10})

  )
