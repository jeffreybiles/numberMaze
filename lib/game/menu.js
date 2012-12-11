ig.module('game.menu')
.requires(
  'impact.game'
)
.defines(function() {
  menu = function() {
    ig.gui.element.add({
      name: 'logging button',
      group: 'pause',
      size: {x: 100, y: 100},
      pos: {x: ig.system.width - 120, y: 20},
      state: {
        normal: {
          image: new ig.Image('media/redButton.png'),
          tile: 0,
          tileSize: 100
        }
      },
      click: function(){
        ig.game.goToCenter()
      }
    })
  }
})