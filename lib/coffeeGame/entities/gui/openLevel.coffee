ig.module('game.entities.gui.openLevel').requires(
  'game.entities.gui.screen',
  'game.entities.gui.centeredTextBox'
).defines ->
  window.EntityOpenLevel = EntityScreen.extend(
    font: new ig.Font('media/helvetica24000.png')

    init: (x, y, settings) ->
      @parent(0, 0, settings)
      @playerAnswer = ""
      textButton = ig.game.spawnEntity(EntityCenteredTextBox, 200, 100, {
          width: 560, height: 100, zIndex: 15,
          text: "You can open this level up for only $#{settings.amount}. ~
            Would you like to do it?"
        })
      yesButton = ig.game.spawnEntity(EntityCenteredTextBox, 530, 250, {
          width: 230, height: 100, text: 'Yes (y)', zIndex: 15
        })
      yesButton.onclick = => @delegate.yes()

      noButton = ig.game.spawnEntity(EntityCenteredTextBox, 200, 250, {
        width: 230, height: 100, text: 'No (n)', zIndex: 15
        })
      noButton.onclick = => @delegate.no()

      @children = [textButton, yesButton, noButton]

    update: ->
        if ig.input.pressed('yes') then @delegate.yes()
        if ig.input.pressed('no') then @delegate.no()

  )