ig.module('game.entities.gates.divisionGate').requires('game.entities.gates.problemGate').defines ->
  window.EntityDivisionGate = EntityProblemGate.extend(
    gateType: 'division'
    init: ( x, y, settings ) ->
      @animSheet =  new ig.AnimationSheet( 'media/tileset.png', @spriteSize.x, @spriteSize.y );
      @parent( x, y, settings )
      @addAnim 'idle', 1, [0]


     makeQuestion: ->
        n1 = @equation()
        n2 = @equation()
        product = n1 * n2
        @question = product + ' / ' + n1
        @correct_answer = n2

    equation: ->
      Math.floor(Math.random()*Math.pow(@difficulty + 1, 1.2) + 1)
  )