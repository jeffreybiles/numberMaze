ig.module('game.entities.gui.pauseScreen').requires(
  'game.entities.gui.rectangle',
  'game.entities.gui.textBox',
  'game.entities.gui.centeredTextBox'
).defines ->

  window.EntityPauseScreen = EntityRectangle.extend(
    init: (x, y, settings) ->
      @parent(0, 0, settings)
      @width = ig.system.width
      @height = ig.system.height
      @backgroundColor = '#ddd'
      @borderColor = '#975'
      @borderSize = 3
      @children = [ig.game.spawnEntity(EntityTextBox, 50, 50, {
        width: ig.system.width - 100, height: ig.system.height - 100,
        backgroundColor: 'white', borderColor: 'black', borderSize: '2', zIndex: 10,
        text: "Pause"
        })]
      ig.game.state = 'paused'

    update: ->
      @parent()
      if ig.input.pressed('accept')
        ig.game.state = 'main'
        @kill()

    kill: ->
      child.kill() for child in @children
      @parent()

  )