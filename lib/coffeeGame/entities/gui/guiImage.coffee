ig.module('game.entities.gui.guiImage').requires('game.entities.gui.rectangle').defines ->
  window.EntityGuiImage = EntityRectangle.extend(
    init: (x, y, settings) ->
      @image = new ig.Image("media/#{settings.fileName}")
      settings['width'] = @image.width
      settings['height'] = @image.height
      @parent(x, y, settings)

    draw: ->
      @image.draw(@x, @y)
  )