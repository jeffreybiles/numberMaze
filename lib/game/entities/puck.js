ig.module(
	'game.entities.puck'
)
.requires(
	'impact.entity'
)
.defines(function(){

EntityPuck = ig.Entity.extend({

	size: {x:30, y:30},
	collides: ig.Entity.COLLIDES.ACTIVE,
	type: ig.Entity.TYPE.A,

	animSheet: new ig.AnimationSheet( 'media/puck.png', 48, 48 ),

	moveSpeed: 100,

	init: function( x, y, settings ) {
		this.parent( x, y, settings );

		this.addAnim( 'idle', 0.1, [0,1,2,3,4,4,4,4,3,2,1] );
	},
	update: function() {
			if( ig.input.state('up') ) {
				this.vel.y = -100;
			}
			else if( ig.input.state('down') ) {
				this.vel.y = 100;
			}
			else {
				this.vel.y = 0
			}

			if(ig.input.state('left')){
				this.vel.x = -100
			} else if( ig.input.state('right')){
				this.vel.x = 100
			} else {
				this.vel.x = 0
			}

			this.parent();
		}
});

});