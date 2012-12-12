ig.module('game.entities.gates.subtractionGate').requires('game.entities.gates.gate').defines ->
  window.EntitySubtractionGate = EntityGate.extend(
    gateType: 'subtraction'

    init: ( x, y, settings ) ->
      @animSheet =  new ig.AnimationSheet( 'media/tileset.png', @spriteSize.x, @spriteSize.y );
      @parent( x, y, settings )
      @addAnim 'idle', 1, [2]

     makeQuestion: ->
        n1 = @equation()
        n2 = @equation()
        high_number = n1 + n2
        @question = high_number + ' - ' + n2
        @correct_answer = n1

    equation: ->
      Math.floor(Math.random()*Math.pow(@difficulty + 1.5, 1.4))

    failMessage: ->
      "The door won't budge./nYour powers of subtraction are not yet strong enough."
  )