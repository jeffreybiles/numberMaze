ig.module('game.entities.gui.startScreen').requires(
  'game.entities.gui.screen',
  'game.entities.gui.centeredTextBox',
  'game.entities.gui.creditsScreen'
).defines ->

  window.EntityStartScreen = EntityScreen.extend(
    init: (x, y, settings) ->
      @parent(0, 0, settings)
      textBox = ig.game.spawnEntity(EntityCenteredTextBox, ig.system.width/2 - 200, 50, {
        width: 400, height: 400,
        backgroundColor: 'white', borderColor: 'black', borderSize: '2', zIndex: 10,
        text: "This is the start screen ~ There will be an awesome logo/picture here.
           ~ Press enter or hit the 'start' button to begin."
      })
      startButton = ig.game.spawnEntity(EntityCenteredTextBox, 250, 500, {
        width: 200, height: 100, zIndex: 15, text: 'Start'
        })
      startButton.onclick = => @startGame()

      creditsButton = ig.game.spawnEntity(EntityCenteredTextBox, 510, 500, {
        width: 200, height: 100, zIndex: 15, text: 'Credits'
        })
      creditsButton.onclick = =>
        ig.game.spawnEntity(EntityCreditsScreen, 0,0, {zIndex: 20, previous: 'EntityStartScreen'})
        @kill()

      @children = [textBox, startButton, creditsButton]

    update: ->
      if(ig.input.pressed('accept'))
        @startGame()

    startGame: ->
      ig.game.load()
      @kill()
  )