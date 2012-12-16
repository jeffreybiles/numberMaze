# This is currently broken.  Fix soon.
ig.module('game.entities.gates.moneyGate').requires(
  'game.entities.gates.gate',
  'game.entities.gui.openLevel'
).defines ->
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

    makeChallenge: ->
      @parent()
      @interface = ig.game.spawnEntity(EntityOpenLevel, null, null, {amount: @amount})
      @interface.delegate = @

    makeQuestion: ->

    reward: ->
      ig.game.stats.money -= @amount
      ig.game.storage.set("money#{@id}")
      ig.game.save()
      @kill()

    passable: ->
      ig.game.stats.money >= @amount

    update: ->
      if @paid == null then @killIfAlreadyPaid()
      @parent()

    yes: ->
      @reward()
      @resolve()

    no: ->
      @resolve()

    failMessage: ->
      "You do not have enough money.  \nCome back when you have $#{@amount}"
  )