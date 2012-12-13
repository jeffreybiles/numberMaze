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
	'game.levels.intro',
	'game.levels.center',
	'game.levels.1',
	'game.levels.2',
	'game.levels.3'
)
.defines(function(){

MyGame = ig.Game.extend({
	font: new ig.Font( 'media/helvetica64EEE.png' ),
	storage: new ig.Storage(),
	state: 'main',
	gate: null,
	level: null,
	timeIncreases: 0,

	update: function() {
		if(this.state == 'main'){
			this.cameraFollow()
		} else if(this.state == 'problem'){
			if(ig.input.state('accept')){
				correct = this.gate.checkAnswer()
				var timer = this.getEntitiesByType( EntityTimer)[0]
				if(correct){
					this.gate.reward()
					this.gate.kill()
					timer.change(5)
				} else {
					timer.change(-5)
				}
				this.state = 'main'
			}
		}

		if(ig.input.state('save')){
			this.save()
		}
		this.parent();
	},

	cameraFollow: function(){
		var player = this.getEntitiesByType( EntityPlayer )[0];
	    if( player ) {
	    	var xDifference = player.pos.x - ig.system.width/2;
	    	var yDifference = player.pos.y - ig.system.height/2;
   	    if (this.screen.x > xDifference + 2 || this.screen.x < xDifference - 2) {
          this.screen.x = (9*this.screen.x + xDifference)/10;
	      } else {
	        this.screen.x = xDifference;
        }
        if (this.screen.y > yDifference + 2 || this.screen.y < yDifference - 2) {
            this.screen.y = (9*this.screen.y + yDifference)/10;
        } else {
        	this.screen.y = yDifference
        }
	    }
	},

	//call changeLevel instead of loadLevel!!!!!!!!!!
	loadLevel: function( level) {
		this.parent(level);
		ig.game.spawnEntity(EntityPlayer, this.nextPlayerPosition.x, this.nextPlayerPosition.y, {})
		this.save();
		ig.game.spawnEntity(EntityDashboard)
		if(this.level != 'Center')
		this.timer = ig.game.spawnEntity(EntityTimer)
	},

	changeLevel: function(level, playerPosition){
		ig.game.loadLevelDeferred(level);
		this.nextPlayerPosition = playerPosition;
	},

	draw: function() {
		this.parent();
		if(this.state == 'problem'){
			var x = ig.system.width/2;
			var y = ig.system.height/2 - 20;
			this.font.draw(this.gate.question, x, y, ig.Font.ALIGN.CENTER)
			this.font.draw(this.gate.player_answer, x, y + 70, ig.Font.ALIGN.CENTER)
		}
	},



  experienceRequired: function(level){
    var requirements = {
      0: 30,//30
      1: 100,//70
      2: 200,//100
      3: 500,//300
      4: 1000,//500
      5: 1800,//800
      6: 3000,//1200
      7: 4800,//1800
      8: 7500 //2700
    }
    return requirements[level]
  },

  goToCenter: function(){
		this.changeLevel( LevelCenter , {x: 700, y: 700})
  },

  togglePause: function(){
  	if (this.state == 'pause'){
  		this.state = 'main'
  	} else {
  		this.state = 'pause'
  	}
  },

	init: function() {
		ig.input.bind( ig.KEY.S, 'save')
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
		this.load()
	},

	save: function(){
		this.storage.set('stats', this.stats)
		this.storage.set('switches', this.switches)
	},

	load: function(){
		if(this.storage.isSet('switches')){
			this.switches = this.storage.get('switches')
		} else {
			this.switches = {introComplete: false}
		}
		if(this.switches.introComplete){
			this.stats = this.storage.get('stats')
			this.goToCenter()
		} else {
			this.stats = {
				addition: {level: 0, experience: 0},
				subtraction: {level: 0, experience: 0},
				multiplication: {level: 0, experience: 0},
				money: 0
			}
			this.nextPlayerPosition = {x: 468, y: 68}
			this.loadLevel( LevelIntro);
		}

		this.state = 'main'
		// ig.gui.element.action('hideGroup', 'pauseMenu')
	},

	resetEverything: function(){
		ig.game.storage.clear();
		this.load()
	},
});

start = function(){
	ig.main( '#canvas', MyGame, 60, 960, 640, 1 );
}
start();
});
