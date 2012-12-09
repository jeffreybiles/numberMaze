ig.module(
  'game.entities.dashboard'
)
.requires(
  'impact.entity'
)
.defines(function(){
  EntityDashboard = ig.Entity.extend({
    font: new ig.Font( 'media/helvetica30EEE.png'),
    spacing: 35,

    init: function(){
      this.pos = {x: 5, y: 5}
    },

    draw: function(){
      // this.font.draw("HELLLOOOOOOOO", 5, 5)
      this.font.draw("$" + ig.game.stats.money, this.pos.x, this.pos.y)
      this.font.draw("+" + ig.game.stats.addition.level, this.pos.x, this.pos.y + this.spacing)
      var padding = this.spacing * 1.25
      this.drawRect(this.pos.x + padding, this.pos.y + padding,
                     200,this.spacing/2, 'white')
      var percent = ig.game.stats.addition.experience/ig.game.experienceRequired(ig.game.stats.addition.level)
      this.drawRect(this.pos.x + padding, this.pos.y + padding,
                    percent * 200, this.spacing/2, 'blue')
    },

    drawRect: function(x, y, width, height, color){
      var ctx = ig.system.context;
      var s = ig.system.scale;
      ctx.fillStyle = color;
      ctx.fillRect(x*s,y*s,width*s,height*s);
    }
  });
});