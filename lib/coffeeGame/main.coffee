ig.module(
  'game.main'
)
.requires(
  'impact.game',
  'impact.font',
  'plugins.impact-storage',

  'game.entities.dashboard',
  'game.entities.player',
  'game.entities.timer',
  'game.entities.gui.rectangle',
  'game.entities.gui.completedLevel',
  'game.entities.gui.pauseScreen',

  'game.levels.intro',
  'game.levels.center',
  'game.levels.1',
  'game.levels.2',
  'game.levels.3'
)
.defines ->

  MyGame = ig.Game.extend(
    font: new ig.Font( 'media/helvetica64EEE.png' )
    storage: new ig.Storage()
    state: 'main'
    gate: null
    level: null

    update: ->
      switch @state
        when 'main'
          @cameraFollow()
          console.log('in main')
          if ig.input.pressed('pause') then console.log('pausing'); ig.game.spawnEntity(EntityPauseScreen)
        when 'problem'
          if(ig.input.state('accept'))
            correct = @gate.checkAnswer()
            timer = @getEntitiesByType( EntityTimer)[0]
            if(correct)
              @gate.reward()
              @gate.kill()
              timer.change(5)
            else
              timer.change(-5)
            @state = 'main'
        when 'paused'
          null

      @save() if(ig.input.state('save'))
      @parent();

    cameraFollow: ->
      player = @getEntitiesByType( EntityPlayer )[0];
      if( player )
        xDifference = player.pos.x - ig.system.width/2;
        yDifference = player.pos.y - ig.system.height/2;
        if (@screen.x > xDifference + 2 || @screen.x < xDifference - 2)
          @screen.x = (9*@screen.x + xDifference)/10;
        else
          @screen.x = xDifference;
        if (@screen.y > yDifference + 2 || @screen.y < yDifference - 2)
            @screen.y = (9*@screen.y + yDifference)/10;
        else
          @screen.y = yDifference

    #call changeLevel instead of loadLevel!!!!!!!!!!
    loadLevel: (level) ->
      @parent(level);
      ig.game.spawnEntity(EntityPlayer, @nextPlayerPosition.x, @nextPlayerPosition.y, {})
      @save();
      ig.game.spawnEntity(EntityDashboard)
      if(@level != 'Center') then @timer = ig.game.spawnEntity(EntityTimer)

    changeLevel: (level, playerPosition) ->
      ig.game.loadLevelDeferred(level);
      @nextPlayerPosition = playerPosition;

    draw: ->
      @parent();
      if(@state == 'problem')
        x = ig.system.width/2;
        y = ig.system.height/2 - 20;
        @font.draw(@gate.question, x, y, ig.Font.ALIGN.CENTER)
        @font.draw(@gate.player_answer, x, y + 70, ig.Font.ALIGN.CENTER)

    experienceRequired: (level) ->
      requirements = {
        0: 30,#30
        1: 100,#70
        2: 200,#100
        3: 500,#300
        4: 1000,#500
        5: 1800,#800
        6: 3000,#1200
        7: 4800,#1800
        8: 7500 #2700
      }
      return requirements[level]

    goToCenter: ->
      @state = 'main'
      @changeLevel( LevelCenter , {x: 700, y: 700})

    togglePause: ->
      if (@state == 'pause')
        @state = 'main'
        ig.game.getEntitiesByType(EntityPauseScreen)[0].kill()
      else
        @state = 'pause'
        ig.game.spawnEntity(EntityPauseScreen)

    init: ->
      ig.input.bind( ig.KEY.S, 'save')
      ig.input.bind( ig.KEY.P, 'pause')
      ig.input.bind( ig.KEY.ENTER, 'accept' );
      ig.input.bind( ig.KEY.UP_ARROW, 'up' );
      ig.input.bind( ig.KEY.DOWN_ARROW, 'down' );
      ig.input.bind( ig.KEY.LEFT_ARROW, 'left' );
      ig.input.bind( ig.KEY.RIGHT_ARROW, 'right' );
      ig.input.bind( ig.KEY._0, '0')
      ig.input.bind( ig.KEY._1, '1')
      ig.input.bind( ig.KEY._2, '2')
      ig.input.bind( ig.KEY._3, '3')
      ig.input.bind( ig.KEY._4, '4')
      ig.input.bind( ig.KEY._5, '5')
      ig.input.bind( ig.KEY._6, '6')
      ig.input.bind( ig.KEY._7, '7')
      ig.input.bind( ig.KEY._8, '8')
      ig.input.bind( ig.KEY._9, '9')
      ig.input.bind( ig.KEY.NUMPAD_0, '0')
      ig.input.bind( ig.KEY.NUMPAD_1, '1')
      ig.input.bind( ig.KEY.NUMPAD_2, '2')
      ig.input.bind( ig.KEY.NUMPAD_3, '3')
      ig.input.bind( ig.KEY.NUMPAD_4, '4')
      ig.input.bind( ig.KEY.NUMPAD_5, '5')
      ig.input.bind( ig.KEY.NUMPAD_6, '6')
      ig.input.bind( ig.KEY.NUMPAD_7, '7')
      ig.input.bind( ig.KEY.NUMPAD_8, '8')
      ig.input.bind( ig.KEY.NUMPAD_9, '9')
      ig.input.bind( ig.KEY.Y, 'yes')
      ig.input.bind(ig.KEY.MOUSE1, 'click')
      @load()

    record: (category, action, label = "", value = null) ->
      for category in ["addition", "subtraction", "multiplication", "division"]
        label += "#{category}:#{ig.game.stats[category].level}  "
      for category in ["money", "timeIncreases"]
        label += "#{category}:#{ig.game.stats[category]}  "
      _gaq.push(['_trackEvent', category, action, label, value])

    save: ->
      @storage.set('stats', @stats)
      @storage.set('switches', @switches)

    load: ->
      @switches = if(@storage.isSet('switches'))
                    @storage.get('switches')
                  else
                    {introComplete: false}

      if(@switches.introComplete)
        @stats = @storage.get('stats')
        @goToCenter()
      else
        @stats = {
          addition: {level: 0, experience: 0},
          subtraction: {level: 0, experience: 0},
          multiplication: {level: 0, experience: 0},
          division: {level: 0, experience: 0},
          timeIncreases: 0,
          money: 0
        }
        @nextPlayerPosition = {x: 468, y: 68}
        @loadLevel( LevelIntro);

      @state = 'main'

    resetEverything: ->
      ig.game.storage.clear();
      @load()
  )

  ig.main( '#canvas', MyGame, 60, 960, 640, 1 );
