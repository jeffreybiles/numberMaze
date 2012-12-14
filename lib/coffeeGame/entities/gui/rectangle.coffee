ig.module('game.entities.gui.rectangle').requires('impact.entity').defines ->
  window.EntityRectangle = ig.Entity.extend(
    init: (@x, @y, settings) ->
      @width = settings.width
      @height = settings.height
      @backgroundColor = settings.backgroundColor
      @borderColor = settings.borderColor
      @borderSize = parseInt(settings.borderSize)
      @container = settings.container
      @ctx = ig.system.context
      if @container
        @x += @container.x
        @y += @container.y
      @zIndex = settings.zIndex || 1
      ig.game.sortEntitiesDeferred()

    update: ->
      if ig.input.pressed('click')
        if @x < ig.input.mouse.x < @x + @width
          if @y < ig.input.mouse.y < @y + @height
            @onclick()

    onclick: ->
      console.log('hello')

    draw: ->
      @ctx.fillStyle = @borderColor;
      @ctx.fillRect(@x, @y, @width, @height)
      @ctx.fillStyle = @backgroundColor
      @ctx.fillRect(@x + @borderSize, @y + @borderSize, @width - @borderSize*2, @height - @borderSize*2)
    )