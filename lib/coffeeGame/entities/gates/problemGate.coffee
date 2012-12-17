ig.module('game.entities.gates.problemGate').requires('game.entities.gates.gate').defines ->
  window.EntityProblemGate = EntityGate.extend(

    makeChallenge: ->
      @parent()
      @interface = ig.game.spawnEntity(EntityProblemInterface,
        null, null, {question: @question}
        )
      @interface.delegate = @

    passable: ->
      @difficulty <= ig.game.stats[@gateType].level

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

    resolve: ->
      correct = @checkAnswer()
      timer = ig.game.getEntitiesByType( EntityTimer)[0]
      if(correct)
        @reward()
        @kill()
        timer.change(5)
      else
        timer.change(-5)
      @parent()

    checkAnswer: ->
      correct = @correct_answer.toString() == @interface.playerAnswer
      correctString = if correct then "correct" else "wrong"
      ig.game.record("#{@gateType}Gate", correctString, null, @difficulty)
      correct

  )