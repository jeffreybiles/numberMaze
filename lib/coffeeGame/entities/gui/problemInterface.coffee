ig.module('game.entities.gui.problemInterface').requires(
  'game.entities.gui.rectangle',
  'game.entities.gui.centeredTextBox'
).defines ->
  window.EntityProblemInterface = EntityRectangle.extend(
    font: new ig.Font('media/helvetica32000.png')
    bigFont: new ig.Font('media/helvetica60000.png')
    init: (x, y, settings) ->
      @padding = 10
      @question = settings.question
      @parent(50, 50, {})
      @width = 860
      @height = 540
      @buttonWidth = 120
      @buttonHeight = 120
      @playerAnswer = ""
      @textCenter = 650
      for i in [1..9]
        row = Math.floor((i-1)/3)
        column = (i-1) % 3
        @makeNumberButton(@x + @padding + column*(@buttonWidth + 10),
                          @y + @padding + row*(@buttonHeight + 10), i)
      @makeNumberButton(@x + @padding + 0*(@buttonWidth + 10),
                        @y + @padding + 3*(@buttonHeight + 10), 0)
      backButton = ig.game.spawnEntity(EntityCenteredTextBox,
                    @x + @padding + @buttonWidth + 10, @y + @padding + 3*(@buttonWidth + 10),
                    {width: @buttonWidth*2 + 10, height: @buttonHeight, zIndex: 15, text: "<- Delete"}
              )
      backButton.onclick = => @backspace()
      @children.push(backButton)

      acceptButton = ig.game.spawnEntity(EntityCenteredTextBox, @textCenter - 100, 400, {
        width: 200, height: 100, text: 'Answer It!', zIndex: 15
        })
      acceptButton.onclick = => @delegate.resolve()
      @children.push(acceptButton)

    backspace: -> @playerAnswer = @playerAnswer[0..-2]

    makeNumberButton: (x, y, number)->
      button = ig.game.spawnEntity(EntityCenteredTextBox, x, y, {
          zIndex: 10, text: "#{number}", width: @buttonWidth, height: @buttonHeight, font: @font
      })
      button.onclick = =>
        @playerAnswer += "#{number}"
      @children.push(button)

    update: ->
      for i in [0..9]
        if ig.input.pressed(i.toString())
          @playerAnswer += i
      if(ig.input.state('accept')) then @delegate.resolve()
      if ig.input.pressed('backspace') then @backspace()
      @parent()

    draw: ->
      @parent()
      @font.draw("Challenge", @textCenter, 100, ig.Font.ALIGN.CENTER)
      @bigFont.draw(@question, @textCenter, 150, ig.Font.ALIGN.CENTER)
      @font.draw("Your Answer", @textCenter, 250, ig.Font.ALIGN.CENTER)
      @bigFont.draw(@playerAnswer, @textCenter, 300, ig.Font.ALIGN.CENTER)
  )