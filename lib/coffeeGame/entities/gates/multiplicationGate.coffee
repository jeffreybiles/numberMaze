ig.module('game.entities.gates.multiplicationGate').requires('game.entities.gates.problemGate').defines ->
  window.EntityMultiplicationGate = EntityProblemGate.extend(
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
      Math.floor(Math.random()*Math.pow(@difficulty + 1, 1.2) + 1)
  )