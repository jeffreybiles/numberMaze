ig.module('game.entities.additionGate').requires('game.entities.gate').defines ->
  window.EntityAdditionGate = EntityGate.extend(
    gateType: 'addition'
    init: ( x, y, settings ) ->
      @animSheet =  new ig.AnimationSheet( 'media/tileset.png', @spriteSize.x, @spriteSize.y );
      @parent( x, y, settings )

     makeQuestion: ->
        n1 = @equation()
        n2 = @equation()
        @question = n1 + ' + ' + n2
        @correct_answer = n1 + n2
        @player_answer = ""

    equation: ->
      Math.floor(Math.random()*Math.pow(@difficulty + 1.5, 1.4))

    passable: ->
      @difficulty <= ig.game.stats.addition.level

    failMessage: ->
      "The door won't budge./nYour powers of addition are not yet strong enough."
  )