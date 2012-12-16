ig.module('game.entities.levelexit')
.requires(  'impact.entity')
.defines ->
  window.EntityLevelexit = ig.Entity.extend(
    _wmDrawBox: true
    _wmBoxColor: 'rgba(0, 0, 255, 0.7)'
    _wmScalable: true
    size: {x: 48, y: 48}
    level: null
    checkAgainst: ig.Entity.TYPE.A
    newPos: {x: 740, y: 700}
    update: ->

    check: ( other ) ->
      if(other instanceof EntityPlayer)
        @nextLevel()

    nextLevel: ->
      if( @level )
        ig.game.record("level", @level)
        level = ig.global['Level'+@level]
        player = ig.game.getEntitiesByType(EntityPlayer)[0]
        player.kill()
        ig.game.changeLevel(level, @newPos)

  )