ig.module(
  'game.entities.cash'
)
.requires(
  'impact.entity',
  'game.entities.message'
)
.defines(function(){
  EntityCash = ig.Entity.extend({
    amount: 1,
    size: {x: 48, y: 48},
    font: new ig.Font( 'media/helvetica64EEE.png' ),
    checkAgainst: ig.Entity.TYPE.A,

    check: function(){
      ig.game.stats.money += this.amount;
      console.log('you got ' + this.amount)
      var message = ig.game.spawnEntity(EntityMessage, "+ $" + this.amount)
      message.pos.y += 50
      this.kill()
    },
    draw: function(){
      this.font.draw("$", this.pos.x - this.offset.x - ig.game.screen.x, this.pos.y - this.offset.y - ig.game.screen.y)
    }
  })
})