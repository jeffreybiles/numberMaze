ig.module('game.entities.gui.screen').requires(
  'game.entities.gui.rectangle',
).defines ->
  window.EntityScreen = EntityRectangle.extend(

    init: (x, y, settings) ->
      @previous = settings.previous
      @parent(0, 0, settings)
      @width = ig.system.width
      @height = ig.system.height
      @backgroundColor = '#ddd'
      @borderColor = '#975'
      @borderSize = 3
      ig.game.state = 'paused'

    kill: ->
      child.kill() for child in @children
      if @previous? then ig.game.spawnEntity(@previous)
      @parent()

  )