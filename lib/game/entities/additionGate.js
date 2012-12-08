ig.module(
  'game.entities.additionGate'
)
.requires(
  'game.entities.gate'
)
.defines(function(){
  EntityAdditionGate = EntityGate.extend({
    init: function( x, y, settings ) {
      this.animSheet =  new ig.AnimationSheet( 'media/tileset.png', this.spriteSize.x, this.spriteSize.y );
      this.parent( x, y, settings );
    },

     makeQuestion: function(){
        n1 = Math.floor(Math.random()*(this.difficulty + 2))
        n2 = Math.floor(Math.random()*(this.difficulty + 2))
        this.question = n1 + ' + ' + n2
        this.correct_answer = n1 + n2
        this.player_answer = ""
    },
  })
})