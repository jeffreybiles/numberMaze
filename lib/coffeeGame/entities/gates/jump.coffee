ig.module('game.entities.gates.jump')
.requires(  'game.entities.gates.gate')
.defines ->
  window.EntityJump = EntityGate.extend(
    collides: ig.Entity.COLLIDES.NONE
    gateType: 'jump'

    init: ( x, y, settings ) ->
      @animSheet =  new ig.AnimationSheet( 'media/tileset.png', @spriteSize.x, @spriteSize.y );
      @parent( x, y, settings )
      @addAnim 'idle', 1, [0]

    check: (other) ->
      console.log(other.vel)
      distance = 48*(@difficulty + 1)
      if other.vel.x > 0
        other.pos.x += distance
      else if other.vel.x < 0
        other.pos.x -= distance
      else if other.vel.y > 0
        other.pos.y += distance
      else if other.vel.y < 0
        other.pos.y -= distance
  )