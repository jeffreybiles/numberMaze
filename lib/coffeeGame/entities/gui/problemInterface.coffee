ig.module('game.entities.gui.problemInterface').requires(
  'game.entities.gui.rectangle',
  'game.entities.gui.centeredTextBox'
).defines ->
  window.EntityProblemInterface = EntityRectangle.extend(
    font: new ig.Font('media/helvetica24000.png')

    init: (x, y, settings) ->
      @question = settings.question
      @parent(50, 50, {})
      @width = 860
      @height = 540
      @buttonWidth = 130
      @buttonHeight = 130
      @playerAnswer = ""
      for i in [1..9]
        row = Math.floor((i-1)/3)
        column = (i-1) % 3
        @makeNumberButton(@x + column*(@buttonWidth + 10), @y + row*(@buttonHeight + 10), i)

    makeNumberButton: (x, y, number)->
      button = ig.game.spawnEntity(EntityCenteredTextBox, x, y, {
          zIndex: 10, text: "#{number}", width: @buttonWidth, height: @buttonHeight
      })
      button.onclick = =>
        @playerAnswer += "#{number}"
      @children.push(button)
    draw: ->
      @parent()
      @font.draw("The question is #{@question}", 500, 100)
      @font.draw("Your answer is #{@playerAnswer}", 500, 150)
  )