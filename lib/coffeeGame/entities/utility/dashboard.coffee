ig.module(
  'game.entities.utility.dashboard'
)
.requires(
  'impact.entity',
  'game.entities.gui.guiImage',
  'game.entities.gui.pauseScreen'
)
.defines ->
  window.EntityDashboard = ig.Entity.extend(
    font: new ig.Font( 'media/helvetica24EEE.png')
    spacing: 28
    barLength: 200

    init: ->
      @pos = {x: 5, y: 5}
      pauseButton = ig.game.spawnEntity(EntityGuiImage, 850, 530, {fileName: "pause.png"})
      pauseButton.onclick = -> ig.game.spawnEntity(EntityPauseScreen)

    draw: ->
      @font.draw("$" + ig.game.stats.money, @pos.x, @pos.y)
      @drawProgressBar('addition', '+', 'blue', 0.15, 0)
      @drawProgressBar('subtraction', '-', 'blue', 0.15, 1)
      @drawProgressBar('multiplication', 'X', 'blue', 0.15, 2)
      @drawProgressBar('division', '%', 'blue', 0.15, 3)

    drawProgressBar: (stat, symbol, fillColor, padPercent, position) ->
      padding = @spacing * (1 + padPercent)
      yValue = @pos.y + padding + position*@spacing
      experience = ig.game.stats[stat].experience
      level = ig.game.stats[stat].level
      experienceRequired = ig.game.experienceRequired(level)
      percent = experience/experienceRequired

      @font.draw(symbol, @pos.x, @pos.y + @spacing*(position+1))
      @font.draw(level, @pos.x + padding, @pos.y + @spacing*(position+1))

      @drawRect(@pos.x + padding*2, yValue, @barLength,@spacing/2, 'white')
      @drawRect(@pos.x + padding*2, yValue, percent * @barLength, @spacing/2, fillColor)
      this.font.draw("#{experience}/#{experienceRequired}",@pos.x + @barLength + @spacing*3, yValue - 10)

    drawRect: (x, y, width, height, color) ->
      ctx = ig.system.context;
      s = ig.system.scale;
      ctx.fillStyle = color;
      ctx.fillRect(x*s,y*s,width*s,height*s);
  )