ig.module('game.entities.gates.moneyGate').requires('game.entities.gates.gate').defines ->
  window.EntityMoneyGate = EntityGate.extend(
    gateType: 'money'
    amount: 1
    id: null
    paid: null

    init: ( x, y, settings ) ->
      @animSheet =  new ig.AnimationSheet( 'media/tileset.png', @spriteSize.x, @spriteSize.y );
      @parent( x, y, settings )
      @addAnim 'idle', 1, [0]
      @id = @difficulty

    killIfAlreadyPaid: ->
      if(ig.game.storage.isSet("money#{@id}"))
        @kill()
      else
        @paid = false

    makeQuestion: ->
      @question = "Press 'y' to unlock for $#{@amount}"
      @correct_answer = "y"


    reward: ->
      ig.game.stats.money -= @amount
      ig.game.storage.set("money#{@id}")
      ig.game.save()

    passable: ->
      ig.game.stats.money >= @amount

    update: ->
      if @paid == null then @killIfAlreadyPaid()
      if ig.input.pressed('yes')
        @player_answer = @player_answer + 'y'
      @parent()

    failMessage: ->
      "You do not have enough money.  \nCome back when you have $#{@amount}"
  )