ig.module(
	'game.main'
)
.requires(
	'impact.game',
	'impact.font',
	'game.levels.intro'
)
.defines(function(){

MyGame = ig.Game.extend({

	// Load a font
	font: new ig.Font( 'media/helvetica64EEE.png' ),
	state: 'main',
	gate: null,
	stats: {
		addition: {level: 0, experience: 0},
		subtraction: {level: 0, experience: 0},
		money: 0
	},

	init: function() {
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
		ig.input.bind( ig.KEY.ENTER, 'accept' );
		this.loadLevel( LevelIntro );
	},

	update: function() {
		if(this.state == 'main'){
			var player = this.getEntitiesByType( EntityPlayer )[0];
	    if( player ) {
	      this.screen.x = player.pos.x - ig.system.width/2;
	      this.screen.y = player.pos.y - ig.system.height/2;
	      if(player.accel.x > 0 && this.instructText) this.instructText = null;
	    }
		} else if(this.state == 'problem'){
			if(ig.input.state('accept')){
				correct = this.gate.checkAnswer()
				if(correct){
					this.gate.reward()
					this.gate.kill()
				} //later when there is a a timer, we can cut off a few seconds
				this.state = 'main'
			}
		} else if (this.state == 'pause'){
			if(ig.input.state('accept')){
				this.state = 'main'
			}
		}
		this.parent();

	},

	draw: function() {
		this.parent();
		if(this.state == 'problem'){
			var x = ig.system.width/2;
			var y = ig.system.height/2 - 20;
			this.font.draw(this.gate.question, x, y, ig.Font.ALIGN.CENTER)
			this.font.draw(this.gate.player_answer, x, y + 70, ig.Font.ALIGN.CENTER)
		}
	}
});


ig.main( '#canvas', MyGame, 60, 960, 640, 1 );

});
