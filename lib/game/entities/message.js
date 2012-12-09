ig.module(
  'game.entities.message'
)
.requires(
  'impact.entity'
)
.defines(function(){
  EntityMessage = ig.Entity.extend({
    font: new ig.Font( 'media/helvetica30EEE.png' ),
    message: null,
    centering: ig.Font.ALIGN.CENTER,
    lifetime: 1,

    init: function(message){
      this.messages = message.split('/n');
      this.idleTimer = new ig.Timer();
      this.pos = {x: ig.system.width/2, y: ig.system.height/2};
    },

    update: function(){
      if (this.idleTimer.delta() > this.lifetime) {
        this.kill()
        return;
      }
    },

    draw: function(){
      for(var i=0; i < this.messages.length ;i++){
        this.font.draw(this.messages[i], this.pos.x + 18, this.pos.y + 30*i, this.centering)
      }
    }
  })
})