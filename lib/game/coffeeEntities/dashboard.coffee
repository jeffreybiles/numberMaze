ig.module(
  'game.entities.dashboard'
)
.requires(
  'impact.entity'
)
.defines ->
  window.EntityDashboard = ig.Entity.extend(
    font: new ig.Font( 'media/helvetica30EEE.png')
    spacing: 35

    init: ->
      @pos = {x: 5, y: 5}

    draw: ->
      @font.draw("$" + ig.game.stats.money, @pos.x, @pos.y)
      @drawProgressBar('addition', '+', 'blue', 0.25, 0)
      @drawProgressBar('subtraction', '- ', 'blue', 0.25, 1)
      # padding = @spacing * 1.25
      # @drawRect(@pos.x + padding, @pos.y + padding,
      #                200,@spacing/2, 'white')
      # percent = ig.game.stats.addition.experience/ig.game.experienceRequired(ig.game.stats.addition.level)
      # @drawRect(@pos.x + padding, @pos.y + padding,
      #               percent * 200, @spacing/2, 'blue')

    drawProgressBar: (stat, symbol, fillColor, padPercent, position) ->
      @font.draw(symbol + ig.game.stats[stat].level, @pos.x, @pos.y + @spacing*(position+1))
      padding = @spacing * (1 + padPercent)
      @drawRect(@pos.x + padding, @pos.y + padding + position*@spacing,
                     200,@spacing/2, 'white')
      percent = ig.game.stats[stat].experience/ig.game.experienceRequired(ig.game.stats[stat].level)
      @drawRect(@pos.x + padding, @pos.y + padding + position*@spacing,
                    percent * 200, @spacing/2, fillColor)


    drawRect: (x, y, width, height, color) ->
      ctx = ig.system.context;
      s = ig.system.scale;
      ctx.fillStyle = color;
      ctx.fillRect(x*s,y*s,width*s,height*s);
  )