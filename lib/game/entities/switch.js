ig.module(
  'game.entities.switch'
)
.requires(
  'impact.entity'
)
.defines(function(){
  EntitySwitch = ig.Entity.extend({
    _wmDrawBox: true,
    _wmBoxColor: 'rgba(0, 0, 255, 0.7)',
    _wmScalable: true,
    size: {x: 48, y: 48},
    checkAgainst: ig.Entity.TYPE.A,
    key: null,
    value: null,

    check: function(){
      ig.game.switches[this.key] = this.value;
      console.log(ig.game.switches[this.key])
      ig.game.save();
      this.kill();
    },

    draw:function(){},
  })
})