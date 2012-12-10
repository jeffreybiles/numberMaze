ig.module(
  'game.entities.chest'
)
.requires(
  'impact.entity'
)
.defines(function(){
  EntityChest = ig.Entity.extend({
    amount: 1,
    type: 'money',
    id: null,
    size: {x: 48, y: 48},
    font: new ig.Font( 'media/helvetica64EEE.png' ),
    checkAgainst: ig.Entity.TYPE.A,
    used: null,

    killIfAlreadyUsed: function(){
      if(ig.game.storage.isSet('chest' + this.id)){
        this.kill()
      } else {
        this.used = false
      }
    },
    update: function(){
      if(this.used == null){
        this.killIfAlreadyUsed()
      }
    },

    check: function(){
      if(this.type == 'money'){
        ig.game.stats.money += this.amount;
        var message = ig.game.spawnEntity(EntityMessage, "+ $" + this.amount)
        message.pos.y += 50
      }
      ig.game.storage.set('chest' + this.id, true)
      this.kill()
    },

    draw: function(){
      this.font.draw("#", this.pos.x - this.offset.x - ig.game.screen.x, this.pos.y - this.offset.y - ig.game.screen.y)
    }
  })
})