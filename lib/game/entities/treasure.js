ig.module(
  'game.entities.treasure'
)
.requires(
  'impact.entity'
)
.defines(function(){
  EntityTreasure = ig.Entity.extend({
    amount: 1,
    id: null,
    size: {x: 48, y: 48},
    font: new ig.Font( 'media/helvetica64EEE.png' ),
    checkAgainst: ig.Entity.TYPE.A,
    used: null,

    check: function(){
      if(ig.game.storage.isSet('treasure' + this.id)){
        this.used = ig.game.storage.get('treasure' + this.id)
      }

      if(this.used){
        var amountUsed = Math.round(this.amount/3);
      } else {
        var amountUsed = this.amount;
      }
      ig.game.stats.money += amountUsed;

      var message = ig.game.spawnEntity(EntityMessage, "+ $" + amountUsed + '/nGood job!')
      message.pos.y += 50
      ig.game.storage.set('treasure' + this.id, 'true')
      this.kill()
      setTimeout(function(){
        ig.game.goToCenter();
      }, 1500)
    },

    draw: function(){
      this.font.draw("#", this.pos.x - this.offset.x - ig.game.screen.x, this.pos.y - this.offset.y - ig.game.screen.y)
    }
  })
})