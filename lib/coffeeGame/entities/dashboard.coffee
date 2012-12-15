ig.module(
  'game.entities.dashboard'
)
.requires(
  'impact.entity',
  'game.entities.gui.guiImage',
  'game.entities.gui.pauseScreen'
)
.defines ->
  window.EntityDashboard = ig.Entity.extend(
    font: new ig.Font( 'media/helvetica30EEE.png')
    spacing: 35
    barLength: 200

    init: ->
      @pos = {x: 5, y: 5}
      pauseButton = ig.game.spawnEntity(EntityGuiImage, 850, 530, {fileName: "pause.png"})
      pauseButton.onclick = -> ig.game.spawnEntity(EntityPauseScreen)

    draw: ->
      @font.draw("$" + ig.game.stats.money, @pos.x, @pos.y)
      @drawProgressBar('addition', '+', 'blue', 0.25, 0)
      @drawProgressBar('subtraction', '- ', 'blue', 0.25, 1)

    drawProgressBar: (stat, symbol, fillColor, padPercent, position) ->
      padding = @spacing * (1 + padPercent)
      yValue = @pos.y + padding + position*@spacing
      experience = ig.game.stats[stat].experience
      level = ig.game.stats[stat].level
      experienceRequired = ig.game.experienceRequired(level)
      percent = experience/experienceRequired

      @font.draw(symbol + level, @pos.x, @pos.y + @spacing*(position+1))
      @drawRect(@pos.x + padding, yValue, @barLength,@spacing/2, 'white')
      @drawRect(@pos.x + padding, yValue, percent * @barLength, @spacing/2, fillColor)
      this.font.draw("#{experience}/#{experienceRequired}",@pos.x + @barLength + @spacing*2, yValue - 10)

    drawRect: (x, y, width, height, color) ->
      ctx = ig.system.context;
      s = ig.system.scale;
      ctx.fillStyle = color;
      ctx.fillRect(x*s,y*s,width*s,height*s);
  )