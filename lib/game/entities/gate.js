ig.module(
  'game.entities.gate'
)
.requires(
  'impact.entity',
  'game.entities.message'
)
.defines(function(){
  EntityGate = ig.Entity.extend({
    spriteSize: {x: 48, y: 48},
    size: {x: 48, y: 48},
    difficulty: 1,
    font: new ig.Font( 'media/helvetica32000.png'),
    _wmScalable: true,

    collides: ig.Entity.COLLIDES.FIXED,
    checkAgainst: ig.Entity.TYPE.A,

    init: function( x, y, settings ) {
      this.parent( x, y, settings );
      this.animSheet =  new ig.AnimationSheet( 'media/tileset.png', this.spriteSize.x, this.spriteSize.y );
      this.addAnim( 'idle', 1, [1] );
    },

    check: function(){
      this.parent()
      if(ig.game.state == 'main'){
        if(this.passable()){
          ig.game.state = 'problem'
          ig.game.gate = this
          this.makeQuestion()
        } else {
          ig.game.spawnEntity(EntityMessage, this.failMessage())
        }
      }
    },

    checkAnswer: function(){
      return this.correct_answer.toString() == this.player_answer
    },


    update: function(){
      for(var i = 0; i < 10; i++){
        if(ig.input.pressed(i.toString())){
          this.player_answer = this.player_answer + i
        }
      }
      this.parent()
    },

    reward: function(){
      this.notice = ""
      var stats = ig.game.stats;
      this.gainMoney(stats);
      this.gainXp(stats);


      message = ig.game.spawnEntity(EntityMessage, this.notice)
      message.pos.y += 50

      ig.game.save();
    },



    gainXp: function(stats){
      var statRaised = stats[this.gateType];
      var xpGained = Math.floor(Math.pow(this.difficulty + 1, 1.5) * 10)
      statRaised.experience += xpGained

      if (statRaised.experience >= ig.game.experienceRequired(statRaised.level)){
        statRaised.experience = 0;
        statRaised.level += 1
        this.notice += "LEVEL UP!\n"
        this.notice += "level " + statRaised.level + " " + this.gateType
      } else {
        this.notice += "+ " + xpGained + 'xp'
      }
    },



    gainMoney: function(stats){
      var moneyGained = Math.floor(Math.pow(this.difficulty + 1, 1.7) * (1 + Math.random()) * 5);
      stats.money += moneyGained
      this.notice += "+ $" + moneyGained + "/n"
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
      this.font.draw(this.difficulty, 5, 5)
      ctx.restore();
    }
  });
});