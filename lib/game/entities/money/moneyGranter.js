// Generated by CoffeeScript 1.3.3
(function() {

  ig.module('game.entities.money.moneyGranter').requires('impact.entity', 'game.entities.utility.message').defines(function() {
    return window.EntityMoneyGranter = ig.Entity.extend({
      size: {
        x: 48,
        y: 48
      },
      font: new ig.Font('media/helvetica64EEE.png'),
      checkAgainst: ig.Entity.TYPE.A,
      path: 1,
      check: function() {
        var message;
        ig.game.stats.money += this.amount();
        message = ig.game.spawnEntity(EntityMessage, "+ $" + this.amount());
        message.pos.y += 50;
        return this.kill();
      },
      amount: function() {
        return this.baseline();
      },
      baseline: function() {
        return Math.round(Math.pow(1.6, this.path + 1));
      }
    });
  });

}).call(this);
