ig.module('game.entities.gui.creditsScreen').requires(
  'game.entities.gui.screen',
  'game.entities.gui.centeredTextBox',
  'game.entities.gui.guiImage',
).defines ->

  window.EntityCreditsScreen = EntityScreen.extend(
    init: (x, y, settings) ->
      @parent(0, 0, settings)
      textBox = ig.game.spawnEntity(EntityCenteredTextBox, ig.system.width/2 - 350, 50, {
        width: 700, height: 400,
        backgroundColor: 'white', borderColor: 'black', borderSize: '2', zIndex: 25,
        text: "Jeffrey Biles (@jeffreybiles) - Programming and game design ~
              Pablo Velasquez (@pablovem) - Art ~
              Chad Robb - Music, maybe"
      })
      backButton = ig.game.spawnEntity(EntityCenteredTextBox, 350, 500, {
        width: 260, height: 100, zIndex: 25, text: 'Back'
        })
      backButton.onclick = =>
        if @timer.delta() > 0
          @kill()

      @children = [textBox, backButton ]

    update: ->
      if(ig.input.pressed('accept'))
        @kill()

  )