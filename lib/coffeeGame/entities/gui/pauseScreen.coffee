ig.module('game.entities.gui.pauseScreen').requires(
  'game.entities.gui.screen',
  'game.entities.gui.centeredTextBox',
  'game.entities.gui.guiImage'
).defines ->

  window.EntityPauseScreen = EntityScreen.extend(
    init: (x, y, settings) ->
      @parent(0, 0, settings)
      textBox = ig.game.spawnEntity(EntityCenteredTextBox, ig.system.width/2 - 100, 50, {
        width: 200, height: 100,
        backgroundColor: 'white', borderColor: 'black', borderSize: '2', zIndex: 10,
        text: "Pause"
        })
      resumeButton = ig.game.spawnEntity(EntityGuiImage, 500, 200, {
        fileName: "resumeLevel.png", zIndex: 15
        })
      resumeButton.onclick = =>
        @kill()
      goToCenterButton = ig.game.spawnEntity(EntityGuiImage, 200, 200, {
        fileName: "goToCenter.png", zIndex: 15
        })
      goToCenterButton.onclick = =>
        ig.game.goToCenter()

      @children = [textBox, resumeButton, goToCenterButton]

    kill: ->
      ig.game.state = 'main'
      @parent()

    update: ->
      @parent()
      if ig.input.pressed('accept')
        @kill()


  )