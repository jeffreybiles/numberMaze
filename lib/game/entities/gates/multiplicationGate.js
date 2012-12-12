// Generated by CoffeeScript 1.3.3
(function() {

  ig.module('game.entities.gates.multiplicationGate').requires('game.entities.gates.gate').defines(function() {
    return window.EntityMultiplicationGate = EntityGate.extend({
      gateType: 'multiplication',
      init: function(x, y, settings) {
        this.animSheet = new ig.AnimationSheet('media/tileset.png', this.spriteSize.x, this.spriteSize.y);
        this.parent(x, y, settings);
        return this.addAnim('idle', 1, [5]);
      },
      makeQuestion: function() {
        var n1, n2;
        n1 = this.equation();
        n2 = this.equation();
        this.question = n1 + ' * ' + n2;
        return this.correct_answer = n1 * n2;
      },
      equation: function() {
        return Math.floor(Math.random() * Math.pow(this.difficulty + 1, 1.2));
      },
      failMessage: function() {
        return "The door won't budge./nYour powers of multiplication are not yet strong enough.";
      }
    });
  });

}).call(this);