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
      @font.draw("+" + ig.game.stats.addition.level, @pos.x, @pos.y + @spacing)
      padding = @spacing * 1.25
      @drawRect(@pos.x + padding, @pos.y + padding,
                     200,@spacing/2, 'white')
      percent = ig.game.stats.addition.experience/ig.game.experienceRequired(ig.game.stats.addition.level)
      @drawRect(@pos.x + padding, @pos.y + padding,
                    percent * 200, @spacing/2, 'blue')

    drawRect: (x, y, width, height, color) ->
      ctx = ig.system.context;
      s = ig.system.scale;
      ctx.fillStyle = color;
      ctx.fillRect(x*s,y*s,width*s,height*s);
  )