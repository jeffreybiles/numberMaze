ig.module(
  'game.entities.levelexit'
)
.requires(
  'impact.entity'
)
.defines(function(){
  EntityLevelexit = ig.Entity.extend({
    _wmDrawBox: true,
    _wmBoxColor: 'rgba(0, 0, 255, 0.7)',
    _wmScalable: true,
    size: {x: 48, y: 48},
    level: null,
    checkAgainst: ig.Entity.TYPE.A,
    newPos: {x: 740, y: 700},
    update: function(){},
    check: function( other ) {
      if(other instanceof EntityPlayer){
        this.nextLevel()
      }
    },
    nextLevel: function(){
      if( this.level ) {

        var level = ig.global['Level'+this.level]
        var player = {
          type: "EntityPlayer",
          x: this.newPos.x,
          y: this.newPos.y,
          settings: {}
        }
        level.entities.push(player)
        ig.game.loadLevelDeferred(level)
      }
    }
  })
})