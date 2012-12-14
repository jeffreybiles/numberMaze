ig.module('game.entities.gates.gate').requires(
  'impact.entity',
  'game.entities.message'
).defines ->
  window.EntityGate = ig.Entity.extend(
    spriteSize: {x: 48, y: 48}
    size: {x: 48, y: 48}
    difficulty: 1
    font: new ig.Font( 'media/helvetica32000.png')
    _wmScalable: true

    collides: ig.Entity.COLLIDES.FIXED
    checkAgainst: ig.Entity.TYPE.A

    init: ( x, y, settings ) ->
      @parent x, y, settings
      @animSheet =  new ig.AnimationSheet( 'media/tileset.png', @spriteSize.x, @spriteSize.y );

    check: ->
      @parent()
      if ig.game.state == 'main'
        if @passable()
          ig.game.state = 'problem'
          ig.game.gate = @
          @makeQuestion()
          @player_answer = ""
        else
          ig.game.spawnEntity(EntityMessage, @failMessage())

    passable: ->
      @difficulty <= ig.game.stats[@gateType].level

    failMessage: ->
      ig.game.record("#{@gateType}Gate", "unpassable") if ig.game.getEntitiesByType(EntityMessage).length == 0
      "The door won't budge./nYour powers of #{@gateType} are not yet strong enough."


    checkAnswer: ->
      correct = @correct_answer.toString() == @player_answer
      ig.game.record("#{@gateType}Gate",
        if correct then "correct" else "wrong",
        @difficulty)
      correct

    update: ->
      for i in [0..9]
        if ig.input.pressed(i.toString())
          @player_answer = @player_answer + i
      @parent()

    reward: ->
      @notice = ""
      stats = ig.game.stats;
      @gainMoney(stats);
      @gainXp(stats);

      message = ig.game.spawnEntity(EntityMessage, @notice)
      message.pos.y += 50

      ig.game.save();


    gainXp: (stats) ->
      statRaised = stats[@gateType];
      xpGained = Math.floor(Math.pow(@difficulty + 1, 1.5) * 10)
      statRaised.experience += xpGained

      if (statRaised.experience >= ig.game.experienceRequired(statRaised.level))
        statRaised.experience = 0;
        statRaised.level += 1
        @notice += "LEVEL UP!\n"
        @notice += "level #{statRaised.level} #{@gateType}"
      else
        @notice += "+ #{xpGained}xp"

    gainMoney: (stats) ->
      moneyGained = Math.floor(Math.pow(@difficulty + 1, 1.7) * 1);
      stats.money += moneyGained
      @notice += "+ $#{moneyGained}/n"

    draw: ->
      ctx = ig.system.context;
      ctx.save();
      ctx.translate( ig.system.getDrawPos( @pos.x - @offset.x - ig.game.screen.x ),
        ig.system.getDrawPos( @pos.y - @offset.y - ig.game.screen.y ) );
      numColumns = Math.floor(@size.x/@spriteSize.x);
      numRows = Math.floor(@size.y/@spriteSize.y);
      for i in [0...numColumns]
        for j in [0...numRows]
          @currentAnim.draw(i*@spriteSize.x, j*@spriteSize.y)
      @font.draw(@difficulty, 5, 5)
      ctx.restore();
  )