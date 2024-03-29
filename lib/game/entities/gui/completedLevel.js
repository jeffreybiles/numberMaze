// Generated by CoffeeScript 1.3.3
(function() {

  ig.module('game.entities.gui.completedLevel').requires('game.entities.gui.screen', 'game.entities.gui.textBox', 'game.entities.gui.centeredTextBox').defines(function() {
    return window.EntityCompletedLevel = EntityScreen.extend({
      init: function(x, y, settings) {
        this.parent(0, 0, settings);
        ig.game.spawnEntity(EntityTextBox, 100, 100, {
          width: ig.system.width - 200,
          height: ig.system.height - 250,
          backgroundColor: 'white',
          borderColor: 'black',
          borderSize: '2',
          zIndex: 10,
          text: "Blessings upon you, fair traveller. ~              You have plumbed the depths of the labyrinth and found your treasure.              Take as your reward $" + settings.money + " and the knowledge that you have              discovered the lost treasure of " + settings.id + "."
        });
        this.acceptBox = ig.game.spawnEntity(EntityCenteredTextBox, ig.system.width / 2 - 100, ig.system.height - 100, {
          width: 200,
          height: 50,
          backgroundColor: 'white',
          borderColor: 'green',
          borderSize: '2',
          text: 'Accept',
          zIndex: 10
        });
        return this.acceptBox.onclick = function() {
          ig.game.goToCenter();
          return this.kill();
        };
      },
      update: function() {
        this.parent();
        if (ig.input.pressed('accept')) {
          return this.acceptBox.onclick();
        }
      }
    });
  });

}).call(this);
