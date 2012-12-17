// Generated by CoffeeScript 1.3.3
(function() {

  ig.module('game.entities.money.treasure').requires('game.entities.money.moneyGranter').defines(function() {
    return window.EntityTreasure = EntityMoneyGranter.extend({
      id: null,
      used: null,
      check: function() {
        if (ig.game.storage.isSet('treasure' + this.id)) {
          this.used = ig.game.storage.get('treasure' + this.id);
        }
        this.parent();
        ig.game.storage.set('treasure' + this.id, 'true');
        ig.game.record('treasure', "" + this.id + " " + this.used, null, this.amountGained);
        return ig.game.spawnEntity(EntityCompletedLevel, null, null, {
          money: this.amount(),
          id: this.id
        });
      },
      amount: function() {
        if (this.used) {
          return this.baseline() * 10;
        } else {
          return this.baseline() * 30;
        }
      },
      draw: function() {
        return this.font.draw("#", this.pos.x - this.offset.x - ig.game.screen.x, this.pos.y - this.offset.y - ig.game.screen.y);
      }
    });
  });

}).call(this);