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
      console.log(this)
      this.font.draw("$" + ig.game.stats.money, this.pos.x, this.pos.y)
      this.font.draw("+" + ig.game.stats.addition.level, this.pos.x, this.pos.y + this.spacing)
    }
  });
});