ig.module('game.entities.gui.completedLevel').requires(
  'game.entities.gui.rectangle',
  'game.entities.gui.textBox',
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
      ig.game.spawnEntity(EntityTextBox, 150, 150, {
        width: ig.system.width - 300, height: ig.system.height - 400,
        backgroundColor: 'white', borderColor: 'black', borderSize: '2', zIndex: 10,
        text: "Blessings upon you, fair traveller. ~
              You have plumbed the depths of the labyrinth and found your treasure.
              Take as your reward $#{settings.money} and the knowledge that you have
              discovered the lost treasure of #{settings.id}."
        })
      @acceptBox = ig.game.spawnEntity(EntityCenteredTextBox,
            ig.system.width/2 - 100, ig.system.height - 200, {
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
