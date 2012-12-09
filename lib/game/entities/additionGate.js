ig.module(
  'game.entities.additionGate'
)
.requires(
  'game.entities.gate'
)
.defines(function(){
  EntityAdditionGate = EntityGate.extend({
    gateType: 'addition',
    init: function( x, y, settings ) {
      this.animSheet =  new ig.AnimationSheet( 'media/tileset.png', this.spriteSize.x, this.spriteSize.y );
      this.parent( x, y, settings );
    },

     makeQuestion: function(){
        n1 = this.equation()
        n2 = this.equation()
        this.question = n1 + ' + ' + n2
        this.correct_answer = n1 + n2
        this.player_answer = ""
    },

    equation: function(){
      return Math.floor(Math.random()*Math.pow(this.difficulty + 1.5, 1.4))
    },

    passable: function(){
      return this.difficulty <= ig.game.stats.addition.level
    },

    failMessage: function(){
      return "The door won't budge./nYour powers of addition are not yet strong enough."
    }
  })
})