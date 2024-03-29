ig.module('game.entities.gates.additionGate').requires('game.entities.gates.problemGate').defines ->
  window.EntityAdditionGate = EntityProblemGate.extend(
    gateType: 'addition'
    init: ( x, y, settings ) ->
      @animSheet =  new ig.AnimationSheet( 'media/tileset.png', @spriteSize.x, @spriteSize.y );
      @parent( x, y, settings )
      @addAnim 'idle', 1, [1]


     makeQuestion: ->
        n1 = @equation()
        n2 = @equation()
        @question = n1 + ' + ' + n2
        @correct_answer = n1 + n2

    equation: ->
      Math.floor(Math.random()*Math.pow(@difficulty + 1.5, 1.4))
  )