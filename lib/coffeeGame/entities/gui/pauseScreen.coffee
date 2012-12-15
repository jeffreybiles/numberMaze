ig.module('game.entities.gui.pauseScreen').requires(
  'game.entities.gui.screen',
  'game.entities.gui.textBox',
  'game.entities.gui.guiImage'
).defines ->

  window.EntityPauseScreen = EntityScreen.extend(
    init: (x, y, settings) ->
      @parent(0, 0, settings)
      @children = [ig.game.spawnEntity(EntityTextBox, 50, 50, {
        width: ig.system.width - 100, height: ig.system.height - 100,
        backgroundColor: 'white', borderColor: 'black', borderSize: '2', zIndex: 10,
        text: "Pause"
        })]
      @children.push(ig.game.spawnEntity(EntityGuiImage, 100, 200, {
        fileName: "pause.png", zIndex: 15
        }))
    update: ->
      @parent()
      if ig.input.pressed('accept')
        ig.game.state = 'main'
        @kill()


  )