ig.module(
  'game.entities.switch'
)
.requires(
  'impact.entity'
)
.defines ->
  window.EntitySwitch = ig.Entity.extend(
    _wmDrawBox: true
    _wmBoxColor: 'rgba(0, 0, 255, 0.7)'
    _wmScalable: true
    size: {x: 48, y: 48}
    checkAgainst: ig.Entity.TYPE.A
    key: null
    value: null

    check: ->
      ig.game.switches[@key] = @value;
      console.log(ig.game.switches[@key])
      ig.game.save();
      @kill();

    draw: ->
  )
