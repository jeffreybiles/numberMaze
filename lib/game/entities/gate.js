ig.module(
  'game.entities.gate'
)
.requires(
  'impact.entity'
)
.defines(function(){
  EntityGate = ig.Entity.extend({
    checkAgainst: ig.Entity.TYPE.A,
    spriteSize: {x: 48, y: 48},

    _wmScalable: true,
    init: function( x, y, settings ) {
      this.parent( x, y, settings );
      this.animSheet =  new ig.AnimationSheet( 'media/tileset.png', this.spriteSize.x, this.spriteSize.y );
      this.addAnim( 'idle', 1, [1] );
    },

    //change this to tile rather than scale, and use this.size.x and this.size.y rather than this.scale
    draw: function(){
    var ctx = ig.system.context;
    ctx.save();
    ctx.translate( ig.system.getDrawPos( this.pos.x - this.offset.x - ig.game.screen.x ),
      ig.system.getDrawPos( this.pos.y - this.offset.y - ig.game.screen.y ) );
    var numColumns = Math.floor(this.size.x/this.spriteSize.x);
    var numRows = Math.floor(this.size.y/this.spriteSize.y);
    console.log(numRows, numColumns)
    console.log(this.spriteSize.x, this.size.x)
    for(var i = 0; i < numColumns; i++){
      for(var j = 0; j < numRows; j++){
        this.currentAnim.draw(i*this.spriteSize.x, j*this.spriteSize.y)
      }
    }
    ctx.restore();
  }
  })
});