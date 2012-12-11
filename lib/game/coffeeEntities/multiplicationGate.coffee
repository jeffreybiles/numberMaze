ig.module('game.entities.multiplicationGate').requires('game.entities.gate').defines ->
  window.EntityMultiplicationGate = EntityGate.extend(
    gateType: 'multiplication'
    init: ( x, y, settings ) ->
      @animSheet =  new ig.AnimationSheet( 'media/tileset.png', @spriteSize.x, @spriteSize.y );
      @parent( x, y, settings )
      @addAnim 'idle', 1, [5]


     makeQuestion: ->
        n1 = @equation()
        n2 = @equation()
        @question = n1 + ' * ' + n2
        @correct_answer = n1 * n2

    equation: ->
      Math.floor(Math.random()*Math.pow(@difficulty + 1, 1.2))

    failMessage: ->
      "The door won't budge./nYour powers of multiplication are not yet strong enough."
  )