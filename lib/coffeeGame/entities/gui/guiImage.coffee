ig.module('game.entities.gui.guiImage').requires('game.entities.gui.rectangle').defines ->
  window.EntityGuiImage = EntityRectangle.extend(
    init: (x, y, settings) ->
      @image = new ig.Image("media/#{settings.fileName}")
      @parent(x, y, settings)

    update: ->
      @width = @image.width
      @height = @image.height
      @parent()

    draw: ->
      @image.draw(@x, @y)
  )