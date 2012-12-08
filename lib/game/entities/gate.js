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
    size: {x: 48, y: 48},
    difficulty: 1,
    questionType: 'addition',
    _wmScalable: true,
    collides: ig.Entity.COLLIDES.FIXED,

    init: function( x, y, settings ) {
      this.parent( x, y, settings );
      this.animSheet =  new ig.AnimationSheet( 'media/tileset.png', this.spriteSize.x, this.spriteSize.y );
      this.addAnim( 'idle', 1, [1] );
    },

    check: function(){
      if(ig.game.state == 'main'){
        ig.game.state = 'problem'
        ig.game.gate = this
        this.makeQuestion()
      }
    },

    makeQuestion: function(){
      //currently only for addition
      n1 = Math.round(Math.random()*this.difficulty)
      n2 = Math.round(Math.random()*this.difficulty)
      this.question = n1 + ' + ' + n2
      this.correct_answer = n1 + n2
      this.player_answer = ""
    },


    update: function(){
      for(var i = 0; i < 10; i++){
        if(ig.input.pressed(i.toString())){
          this.player_answer = this.player_answer + i
          console.log('pressed button')
        }
      }
    },

    draw: function(){
      var ctx = ig.system.context;
      ctx.save();
      ctx.translate( ig.system.getDrawPos( this.pos.x - this.offset.x - ig.game.screen.x ),
        ig.system.getDrawPos( this.pos.y - this.offset.y - ig.game.screen.y ) );
      var numColumns = Math.floor(this.size.x/this.spriteSize.x);
      var numRows = Math.floor(this.size.y/this.spriteSize.y);
      for(var i = 0; i < numColumns; i++){
        for(var j = 0; j < numRows; j++){
          this.currentAnim.draw(i*this.spriteSize.x, j*this.spriteSize.y)
        }
      }
      ctx.restore();
    }
  })
});