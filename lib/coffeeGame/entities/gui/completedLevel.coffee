ig.module('game.entities.gui.completedLevel').requires(
  'game.entities.gui.screen',
  'game.entities.gui.textBox',
  'game.entities.gui.centeredTextBox'
).defines ->

  window.EntityCompletedLevel = EntityScreen.extend(
    init: (x, y, settings) ->
      @parent(0, 0, settings)
      ig.game.spawnEntity(EntityTextBox, 100, 100, {
        width: ig.system.width - 200, height: ig.system.height - 250,
        backgroundColor: 'white', borderColor: 'black', borderSize: '2', zIndex: 10,
        text: "Blessings upon you, fair traveller. ~
              You have plumbed the depths of the labyrinth and found your treasure.
              Take as your reward $#{settings.money} and the knowledge that you have
              discovered the lost treasure of #{settings.id}."
        })
      @acceptBox = ig.game.spawnEntity(EntityCenteredTextBox,
            ig.system.width/2 - 100, ig.system.height - 100, {
            width: 200, height: 50, backgroundColor: 'white',
            borderColor: 'green', borderSize: '2', text: 'Accept', zIndex: 10})
      @acceptBox.onclick = ->
        ig.game.goToCenter()
        @kill()

    update: ->
      @parent()
      if ig.input.pressed('accept')
        @acceptBox.onclick()
  )
